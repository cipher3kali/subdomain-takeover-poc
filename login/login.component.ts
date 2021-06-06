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





