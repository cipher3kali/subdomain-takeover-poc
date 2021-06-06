

loginserive







import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

import { HttpClient } from '@angular/common/http';



@Injectable({
  providedIn: 'root'
})
export class LoginService {

  loginURL = "http://localhost:3000/user/login";

  constructor(private http: HttpClient) { }

  //to access the user detail that is already registered and login to the profile
  login(data: any): Observable<any> {
    return <Observable<any>>this.http.post(this.loginURL, data);
  }
}

  
  
  
  login.component.ts
  ------------------
  import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { Location } from '@angular/common';
import { LoginService } from './loginService';
import { AppComponent } from '../../app.component';
import { MatSnackBar } from '@angular/material';



@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  errorMessage: string;
  loginForm: FormGroup;
  registerPage = false;
  contactNo = '';
  contactEmail = '';
  emailId = '';
  hide = true;
  key = false;
  show = true;



  constructor(private _snackBar: MatSnackBar, private location: Location, private fb: FormBuilder, private router: Router, private loginService: LoginService, private app: AppComponent) {
    sessionStorage.setItem("PreviousUrl", sessionStorage.getItem("CurrentUrl"));
    sessionStorage.setItem("CurrentUrl", this.router.url);
  }

  ngOnInit() {




    document.getElementsByTagName('div')[0].focus();
    window.scrollTo(0, 0)
    //login form appears on page load and contains 2 fields
    this.loginForm = this.fb.group({
      emailId: [''],
      contactEmail: ['', [Validators.required, Validators.pattern(/^([a-z][a-zA-Z0-9_]*(\.[a-zA-Z][a-zA-Z0-9_]*)?@[a-z][a-zA-Z-0-9]*\.[a-z]+(\.[a-z]+)?)|[7-9][0-9]{9}$/)]],
      password: ['', [Validators.required, Validators.pattern(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{7,20}$/)]]
    })
  }
  //to open snack bar
  openSnackBar(message: string, action: string) {
    this._snackBar.open(message, action, {
      duration: 5000,
      verticalPosition: 'top',
      panelClass: ['snackbar-position'],
      horizontalPosition: "center"

    });
  }

  //to login to a user profile
  login() {
    this.validateContactEmail(this.loginForm.value.contactEmail)

    this.loginService.login(this.loginForm.value).subscribe(
      (response) => {
        sessionStorage.setItem("contactNo", response.contactNo);
        sessionStorage.setItem("userId", response.userId);
        sessionStorage.setItem("emailId", response.emailId);
        sessionStorage.setItem("name", response.name);
        this.openSnackBar('Logged in successfully', 'Ok');
        if (this.loginForm.value.emailId == "admin@gmail.com") {
          this.router.navigate(['/admin'])
        }
        else {
          this.router.navigate(['/home'])
        }
        this.errorMessage = null;
        this.app.reload()
      },
      (errorResponse) => {

        this.errorMessage = errorResponse.error.message;
        sessionStorage.clear();
      }

    )
  };

  //validator to check the entered email
  validateContactEmail(inputtxt) {
    var contact = /^\d{10}$/;
    if (inputtxt.match(contact)) {
      return this.loginForm.value.contactNo = inputtxt;
    }
    else {
      return this.loginForm.value.emailId = inputtxt;
    }
  }

  //open register page if the user is not registered already
  getRegisterPage() {
    this.registerPage = true;

    this.router.navigate(['/register'])
  }
}





hmtl
  
  
  
  
  <mat-grid-list cols="4" rowHeight="310px">


    <mat-grid-tile [colspan]=3 [rowspan]=2 class="new" >
        <mat-card class="my-card offset-4 " >
            <h1 align="center">Login </h1>
            <mat-card-content>
                <form class="my-form" [formGroup]="loginForm" (ngSubmit)="login()">

                    <mat-form-field class="full-width">
                        <mat-label>Email</mat-label>
                        <input type="text" matInput placeholder="Email" tabindex="1" name="contactEmail" required formControlName="contactEmail">
                        <mat-error *ngIf="loginForm.controls.contactEmail.errors?.required && loginForm.controls.contactEmail.dirty" class="text-danger">Field Required</mat-error>
                        <mat-error *ngIf=loginForm.controls.contactEmail.errors class="text-danger" id="ContactEmailError">Enter valid ContactNo/EmailId</mat-error>
                    </mat-form-field>
                    <mat-form-field class="full-width">
                        <mat-label>Password</mat-label>
                        <input matInput placeholder="Password" formControlName="password" required name="password" [type]="hide ? 'password' : 'text'"
                            tabindex="2">
                        <button mat-icon-button matSuffix (click)="hide = !hide" [attr.aria-label]="'Hide password'" [attr.aria-pressed]="hide" tabindex="3">
                            <mat-icon>{{hide ? 'visibility_off' : 'visibility'}}</mat-icon>
                        </button>
                        <mat-error *ngIf="loginForm.controls.password.errors?.required && loginForm.controls.password.dirty" class="text-danger">Field Required</mat-error>
                        <mat-error *ngIf="loginForm.controls.password.errors?.pattern " class="text-danger" id="PasswordError">Enter valid Password</mat-error>
                    </mat-form-field>

                </form>
            </mat-card-content>
            <mat-card-actions>
                <button mat-raised-button [disabled]="loginForm.invalid" class="btn-block" matTooltip="Click here to Login" matTooltipPosition="below"
                    matTooltipClass="mat-tooltip" (click)="login()" (keyup.enter)="login()" tabindex="4" color="primary">LOGIN</button>
                <br />
                <br />
                <a class="link" (click)="getRegisterPage()" (keyup.enter)="getRegisterPage()" tabindex="5" id="enter_btn">Click here to register</a>

            </mat-card-actions>
            <div *ngIf="errorMessage!=null" class="text-danger">
                {{errorMessage}}
            </div>
        </mat-card>
    </mat-grid-tile>
</mat-grid-list>
  
  
  
  
  
  
  
  
  .css
 
  
  
  
  
  
  
  
  .my-form{
    min-width: 200px;
    max-width: 500px;
    width: 100%;
  }
   
  .full-width {
    width: 100%;
  }
  .new{
    background-color:rgb(240, 240, 240);
  }

.green-snackbar {
    background:green;
}
::ng-deep .mat-tooltip{
  background-color:black;
  color:white;
  height: 50%;
  font-size: 13px;
}
