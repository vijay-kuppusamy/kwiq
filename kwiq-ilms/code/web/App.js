import React, { Component } from 'react';
import {Navbar, Nav, FormControl, Button, Form, Carousel, Breadcrumb} from 'react-bootstrap';


class App extends Component{
   render(){
                var bgColors = { "Default": "#0094cf",
                "Blue": "#00B1E1",
                "Cyan": "#37BC9B",
                "Green": "#8CC152",
                "Red": "#E9573F",
                "Yellow": "#ffcd03",
                
            };
      return( 
        <div class="d-flex flex-column" style={{backgroundColor: bgColors.Default}}>
            <div class="p-2">
            <>
              <Navbar bg="primary" variant="light">
                <Navbar.Brand href="#home"><h2>Kwiq Academy</h2></Navbar.Brand>
                <Nav className="mr-auto">
                  <Nav.Link href="#home">Home</Nav.Link>
                  <Nav.Link href="#courses">Courses</Nav.Link>
                  <Nav.Link href="#test">Test</Nav.Link>
                </Nav>
                <Form inline>
                  <FormControl type="text" placeholder="Search" className="mr-sm-2" />
                  <Button variant="outline-light">Search</Button>
                </Form>
              </Navbar>
             </>
             </div>
          <div class="p-2">
              <Carousel>
                <Carousel.Item>
                  <img
                    className="d-block w-100"
                    src="assets/CarouselBG.jpg"
                    alt="Announcements"
                  />
                  <Carousel.Caption>
                    <h3>Announcements</h3>
                    <p>Latest Announcements ... </p>
                  </Carousel.Caption>
                </Carousel.Item>
                <Carousel.Item>
                  <img
                    className="d-block w-100"
                    src="assets/CarouselBG1.jpg"
                    alt="News"
                  />

                  <Carousel.Caption>
                    <h3>Events</h3>
                    <p>Happening events</p>
                  </Carousel.Caption>
                </Carousel.Item>
                <Carousel.Item>
                  <img
                    className="d-block w-100"
                    src="assets/CarouselBG2.jpg"
                    alt="Events"
                  />

                  <Carousel.Caption>
                    <h3>News</h3>
                    <p>Latest News</p>
                  </Carousel.Caption>
                </Carousel.Item>
              </Carousel>
          </div>
          <div class="p-2">    
          <Breadcrumb>
          <Breadcrumb.Item href="#"><h2>NEET</h2></Breadcrumb.Item>
          </Breadcrumb>
          <p>The National Eligibility cum Entrance Test-Under Graduate (NEET-UG), formerly the All India Pre-Medical Test (AIPMT) is an entrance examination in India for students who wish to study undergraduate medical courses (MBBS) and dental courses (BDS) in government or private medical colleges and dental colleges in India.</p>
          </div>
          
          <div class="p-2">
          <Breadcrumb >
          <Breadcrumb.Item href="#"><h3>Recent Videos</h3></Breadcrumb.Item>
          </Breadcrumb>
          <iframe src="https://www.youtube.com/embed/v64KOxKVLVg" width='300' height='300'/>
          <iframe src="https://www.youtube.com/embed/v64KOxKVLVg" width='300' height='300'/>
          <iframe src="https://www.youtube.com/embed/v64KOxKVLVg" width='300' height='300'/>
          </div>

          <div class="p-2">
          <Breadcrumb>
          <Breadcrumb.Item href="#"><h3>About Us</h3></Breadcrumb.Item>
          </Breadcrumb>
          </div>

        </div>
        
      );
   }
}
export default App;