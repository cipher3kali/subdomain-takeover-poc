import { NgModule } from '@angular/core';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { MaterialModule } from './shared/material/material.module';
import { HttpClientModule } from '@angular/common/http';
import { SharedModule } from './shared/shared.module';
import { FormsModule,ReactiveFormsModule } from '@angular/forms';
import { RegisterComponent } from './register/register.component';
import { SearchComponent } from './search/search.component';
import { AdminComponent } from './admin/admin.component';
import { SellerprofileComponent } from './sellerprofile/sellerprofile.component';
import { UpdateprofileComponent } from './updateprofile/updateprofile.component';
import { MatProgressBarModule } from '../../node_modules/@angular/material';

@NgModule({
  declarations: [
    AppComponent,
    SearchComponent,
    RegisterComponent,
    AdminComponent,    
    SellerprofileComponent,
    UpdateprofileComponent,   
  ],
 
  

  imports: [
    AppRoutingModule,
    MatProgressBarModule,  
    MaterialModule,
    BrowserAnimationsModule,
    HttpClientModule,
    SharedModule,
    FormsModule,   
    ReactiveFormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
