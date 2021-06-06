import { async, ComponentFixture, TestBed } from '@angular/core/testing';
import { LoginComponent } from './login.component';
import { AppComponent } from '../../app.component';
// import { BrowserAnimationsModule } from '../../../node_modules/@angular/platform-browser/animations';
// import { RouterTestingModule } from '../../../node_modules/@angular/router/testing';
// import { HttpClientModule } from '../../../node_modules/@angular/common/http';
// import { ReactiveFormsModule, FormsModule } from '../../../node_modules/@angular/forms';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatNativeDateModule, MatSnackBarModule, MatIconModule, MatDialogModule, MatButtonModule, MatTableModule, MatPaginatorModule, MatSortModule, MatTabsModule, MatCheckboxModule, MatToolbarModule, MatCard, MatCardModule, MatFormField, MatFormFieldModule, MatProgressSpinnerModule, MatInputModule, MatSidenavModule, MatGridListModule, MatExpansionModule, MatSlideToggleModule, MatChipsModule} from '@angular/material';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { MatSliderModule } from '@angular/material/slider';
import { MatDividerModule } from '@angular/material/divider';


import {MatListModule} from '@angular/material/list';

import { MatMenuModule } from '@angular/material/menu';
import { MatButtonToggleModule } from '@angular/material/button-toggle';
import {MatDialog, MatDialogRef, MAT_DIALOG_DATA} from '@angular/material/dialog';

import {MatTooltipModule} from '@angular/material/tooltip';

import { ScrollingModule } from '@angular/cdk/scrolling';
import { FormsModule, ReactiveFormsModule } from '../../../../node_modules/@angular/forms';
import { HttpClientModule } from '../../../../node_modules/@angular/common/http';
import { RouterTestingModule } from '../../../../node_modules/@angular/router/testing';
import { BrowserAnimationsModule } from '../../../../node_modules/@angular/platform-browser/animations';


describe('LoginComponent', () => {
  let component: LoginComponent;
  let fixture: ComponentFixture<LoginComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LoginComponent ],
      providers:[AppComponent],
      imports: [MatTooltipModule,MatSliderModule,MatMenuModule,MatListModule, MatAutocompleteModule,
        MatIconModule, ScrollingModule, MatChipsModule, MatSlideToggleModule, MatExpansionModule,
         MatGridListModule, MatButtonToggleModule, MatSidenavModule, MatTabsModule, MatDividerModule, 
         MatSliderModule, MatSelectModule, MatRadioModule, MatNativeDateModule, MatDatepickerModule,
          MatSnackBarModule, MatIconModule, MatDialogModule, MatProgressSpinnerModule, MatButtonModule, 
          MatSortModule, MatTableModule, MatTabsModule, MatCheckboxModule, MatToolbarModule, MatCardModule,
           MatFormFieldModule, MatProgressSpinnerModule, MatInputModule, MatPaginatorModule,
           BrowserAnimationsModule,RouterTestingModule,HttpClientModule,ReactiveFormsModule,FormsModule],
      })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LoginComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
