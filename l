import { Component, OnInit, Inject, TemplateRef } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { BuyService } from './buy.service';
import { MAT_DIALOG_DATA, MatDialog, MatDialogConfig, MatSnackBar } from '../../../../node_modules/@angular/material';
import { PropertyData } from '../property';
import { Location } from '../location';


@Component({
  selector: 'app-buyer',
  templateUrl: './buyer.component.html',
  styleUrls: ['./buyer.component.css']
})

export class BuyerComponent implements OnInit {
  view_propertyId:string;
  propertyArr: PropertyData[] = [];
  errorMessage:string;
  propArr: PropertyData[]=[];
  view:Boolean=true;
  view_obj:String;
  owner_name:String;
  owner_contact:Number;
  owner_emailId:String;
  userName:string;
  userLoggedIn;
  valArr:string[];
  bedroom:Number;
  bathroom:Number;
  min_amt:Number;
  max_amt:Number;
  area:string;
  sale_rent:string;
  prop_type:string;
  location_array:Location[]=[];
  propertyNew=[];
  state:Number;
  one:boolean=true;
 side:boolean=false;
  hide:boolean=false;
  showspinner:boolean=false
  newCard:boolean=false;
  constructor(private buyService: BuyService, public dialog: MatDialog, private route: ActivatedRoute, private _snackBar: MatSnackBar,) { }

  _id

  ngOnInit() {

    this.load()
    this.view = true;
    this.get_property_details()
    this.get_property_location()
    this.userName=sessionStorage.getItem('name')
   if(this.userName){
     this.userLoggedIn=true;
     this.wishing()
   }else{
     this.userLoggedIn=false;  
   }
}
reload(){
  for(let p of this.propertyArr){
    for(let q of this.propertyNew){
      if(p.propertyId==q.propertyId){
        p.status_wishlist=true;
        break
      }else{
        p.status_wishlist=false;
      }
    }
  }
}

  //this function opens a snackbar to display warning message to ask your to login to wishlist
  access(data) {
    this.openSnackBar('Please login to ' + data, 'OK');
  }

  //this wishlists a property on clcik of the heart and undo it on the next click
  click(pid, state) {
    if (state == 1) {
      state = 0
      this.openSnackBar(pid + ' Removed from wishlist', 'OK')
    } else if (state == 0) {
      state = 1
      this.openSnackBar(pid + ' Added to wishlist', 'OK')
    }
    let userId = sessionStorage.getItem('userId')

    this.buyService.checkWish(userId, pid, state).subscribe(
      (success) => {
        this.wishing()
      }
    )
  }
//to obtains the property array and populate the array
  get_property_details() {
    this.buyService.buy().subscribe(

      response => {
        console.log(response)
        this.propertyArr = response;
        this.propArr = response
      }, err => this.errorMessage = err.error.message
    )
  }
//to get the location values
  get_property_location() {
    this.buyService.property_location().subscribe(
      response => {
        this.location_array = response
        this.set_parameters()
      }
    )
  }

  //to open a dialog box on click of contact owner
  openDialog(templateref: TemplateRef<any>, property_obj: any) {
    this.buyService.getuserdata().subscribe(
      response => {
        response.forEach(element => {
          if (property_obj.sellerId == element.userId) {
            this.owner_name = element.name
            this.owner_contact = element.contactNo
            this.owner_emailId = element.emailId
          }
        });
      }
    )
    this.dialog.open(templateref);
  }

  // this is to open a snackbar
  openSnackBar(message: string, action: string) {
    this._snackBar.open(message, action, {
      duration: 5000,
      verticalPosition: 'top',
      panelClass: ['snackbar-position'],
      horizontalPosition: "center"
    });
  }


  redirectfunc(propertyId) {
    this.view = false
    this.buyService.view(propertyId).subscribe(
      response => {
        this.propertyArr = response;
      }, err => this.errorMessage = err.error.message
    )
  }


  //
  counter(i: number) {
    return new Array(i);
  }

  //this is to display a snackbar if user is not logged in 
  snackView() {
    this.openSnackBar('Please login to view details', 'OK');
  }


  set_parameters() {
    this.route.params.subscribe(param => {
      this.area = param['location']
      this.filter_func()
    })
  }

  //Filtering the property based on selected data
  property_for(data) { this.propertyArr = this.propertyArr.filter(_ => _.propertyType == data) }
  property_type(data) { this.propertyArr = this.propertyArr.filter(_ => _.buildingType == data) }
  bedrooms(data) { this.propertyArr = this.propertyArr.filter(_ => _.noOfBedrooms == data) }
  bathrooms(data) { this.propertyArr = this.propertyArr.filter(_ => _.noOfBathrooms == data) }
  minAmount(data) { this.propertyArr = this.propertyArr.filter(_ => _.price >= data) }
  maxAmount(data) { this.propertyArr = this.propertyArr.filter(_ => _.price <= data) }
  areas(data: string) {
    let pincode: Number

    this.location_array.forEach(element => {
      if (element.area.toLowerCase() == data.toLowerCase()) {
        pincode = element.pincode
      }
    });
    this.propertyArr = this.propertyArr.filter(_ => _.pincode == pincode)
  }



  //to filter the available properties based on the options available
  filter_func() {
    this.propertyArr = this.propArr;
    if (this.area) {
      this.areas(this.area);
    }
    if (this.sale_rent) {
      if (this.sale_rent != "Both") {
        this.property_for(this.sale_rent)
      }
    }
    if (this.prop_type) {
      if (this.prop_type != "Both") {
        this.property_type(this.prop_type)
      }
    }
    if (this.min_amt) {
      this.minAmount(this.min_amt)
    }
    if (this.max_amt) {
      this.maxAmount(this.max_amt)
    }
    if (this.bedroom) {
      this.bedrooms(this.bedroom)
    }
    if (this.bathroom) {
      this.bathrooms(this.bathroom)
    }
  }


  //to clear all the applied filters
  clear_filters() {
    this.propertyArr = this.propArr;
    this.bathroom = null;
    this.bedrooms = null;
    this.minAmount = null;
    this.maxAmount = null;
    this.area = null;
    this.prop_type = null;
    this.sale_rent = null;
  }





  //to bring the wishlisted items from the wishlist array
  wishing() {
    this.buyService.wish(sessionStorage.getItem('userId')).subscribe(
      (success) => {
        this.propertyNew = success
        if (this.one) {
          this.reload()
          this.one = false;
        }
      }
    )
  }


  //to show the load spinner
  load() {
    this.showspinner = true;
    setTimeout(() => {
      this.showspinner = false
    }, 1500)
  }

// to open a side navbar on click of a button
  side_show(){
    this.side=!this.side
  }

}



