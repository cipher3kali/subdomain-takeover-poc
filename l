ngOnInit() {
    this.isShown = false;
    this.userName = sessionStorage.getItem('name')
    if (this.userName) {
      this.userLoggedIn = true;
    } else {
      this.userLoggedIn = false;

    }
  }
  
  
  reload(){
    this.ngOnInit()
  }
