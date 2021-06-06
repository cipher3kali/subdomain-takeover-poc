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
