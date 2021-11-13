/**
 This program illustrates colliding of two objects which have circular movement
 
 Processing language accepts clockwise angels positive and above translate(x,y) point is negative for y, right side of translate(x,y) point is positive for x
*/



float r = 250; //radius of the orbit (meters)

float m1= 5;    //mass of the first object (kilograms)
float m2= 10;   //mass of the second object (kilograms) 

float w1 = -PI/5;  //angular velocity of the first object (radians/second)
float w2 = PI/7;  //angular velocity of the second object (radians/second)

Float a1 = PI;     //angle between the first object and (0,r) point (radians)
float a2 = PI*4/2;  //angle between the second object and (0,r) point (radians)

float wall = PI*3/2; //angle between the wall and (0,r) point (radians)(0 <= wall <= 2*PI)
float wallLength = r/8; //half of wall's length

int frequency = 32;  //frame number per second
int time = 1000/frequency; //delay time at each frame

color c = color(0, 0, 0, 150); //color of orbit
color c1 = color(0,100,240,250); //color of object1
color c2 = color(220,90,20,250); //color of object2
color w = color(0,0,0); //color of wall

float radiusSum = (m1 + m2); 
float r1 = map(m1, 0, m1+radiusSum, r/16, r/8); //radius of the first object's circle
float r2 = map(m2, 0, m2+radiusSum, r/16, r/8); //radius of the second object's circle

float x1,y1,x2,y2; //coordinates of objects (meters)
float d1,d2;  //angle between objects and wall
float I1 = m1*r*r; //moment of inertia that the first object have
float I2 = m2*r*r; //moment of inertia that the second object have
float momentum1, energy1; //Total energy and momentum before collision

boolean objectsCollided = false; //whether objects collided in the previous frame
boolean object1WallCollided = false; //whether object1 and wall collided in the previous frame
boolean object2WallCollided = false; //whether object2 and wall collided in the previous frame
boolean objectsCollide; //whether objects collide with each other within the next frame
boolean object1WallCollide; //whether object1 collide with wall within the next frame
boolean object2WallCollide; //whether object2 collide with wall within the next frame
float objectsCollisionTime; //the remaining time before objcets collide (if they collide within the next frame) (unit is frame = 1/frequency seconds)
float object1WallCollisionTime; //the remaining time before objcet1 collides with wall (if it collides within the next frame) (unit is frame = 1/frequency seconds) 
float object2WallCollisionTime; //the remaining time before objcet2 collides with wall (if it collides within the next frame) (unit is frame = 1/frequency seconds) 


void setup(){
  size (720,600);  
  
}

void draw(){
  background(255); 
 
 //Calculating total energy and momentum
 momentum1 = w1*I1 + w2*I2;
 energy1 = I1*pow(w1,2)/2 + I2*pow(w2,2)/2; 
  

 println(w1 + " , " +w2);

 

  
  //Checking wheter objects will collide with wall within the next frame and calculating the time that will take
 if(w1 >= 0)
 {   
   //Calculating the angle between object1 and wall
   if(wall-(a1%(PI*2)) <= 0)
   {
     d1 = (wall-(a1%(PI*2)))%(PI*2) + (PI*2);
   }
   
   else
   {
     d1 = (wall-(a1%(PI*2)))%(PI*2);
   }
   
   //Calculating object1WallCollide and object1WallCollisionTime
   if(object1WallCollided)
   {
     object1WallCollide = false;
   }
   
   else if(w1/frequency >= d1)
   {
     object1WallCollide = true;
     object1WallCollisionTime = d1 / (w1/frequency);
   }
   
   else
   {
     object1WallCollide = false;
   }
 } 
 
 else
 {   
   //Calculating the angle between object1 and wall
   if(wall-(a1%(PI*2)) <= 0)
   {
     d1 = (wall-(a1%(PI*2)))%(PI*2);
   }
   
   else
   {
     d1 = (wall-(a1%(PI*2)))%(PI*2) - (PI*2);
   }
   
   //Calculating object1WallCollide and object1WallCollisionTime
   if(object1WallCollided)
   {
     object1WallCollide = false;
   }
   
   else if(w1/frequency <= d1)
   {
     object1WallCollide = true;
     object1WallCollisionTime = d1 / (w1/frequency);
   }
   
   else
   {
     object1WallCollide = false;
   }
 }
 
 
 
 if(w2 >= 0)
 {
   //Calculating the angle between object2 and wall
   if(wall-(a2%(PI*2)) <= 0)
   {
     d2 = (wall-(a2%(PI*2)))%(PI*2) + (PI*2);
   }
   
   else
   {
     d2 = (wall-(a2%(PI*2)))%(PI*2);
   }
   
   //Calculating object2WallCollide and object2WallCollisionTime
   if(object2WallCollided)
   {
     object2WallCollide = false;
   }
   
   else if(w2/frequency >= d2)
   {
     object2WallCollide = true;
     object2WallCollisionTime = d2 / (w2/frequency);
   }
   
   else
   {
     object2WallCollide = false;
   }
 }
 
 else
 {
   //Calculating the angle between object2 and wall
   if(wall-(a2%(PI*2)) <= 0)
   {
     d2 = (wall-(a2%(PI*2)))%(PI*2);
   }
   
   else
   {
     d2 = (wall-(a2%(PI*2)))%(PI*2) - (PI*2);
   }
   
   //Calculating object2WallCollide and object2WallCollisionTime
   if(object2WallCollided)
   {
     object2WallCollide = false;
   }
   
   else if(w2/frequency <= d2)
   {
     object2WallCollide = true;
     object2WallCollisionTime = d2 / (w2/frequency);
   }
   
   else
   {
     object2WallCollide = false;
   }
 }
 
 
 
 
 

 //Checking wheter objects will collide with each other within the next frame and calculating the time that will take
 if(objectsCollided)
 {
   objectsCollide = false;
 }
 
 else if(equal(mainMeasure(a1),wall) && equal(mainMeasure(a2),wall))
 {
   objectsCollide = false;
 }
 
 else if((mainMeasure(a1) <= wall && mainMeasure(a2) <= wall) || (mainMeasure(a1) >= wall && mainMeasure(a2) >= wall)) 
 {
   if(mainMeasure(a1) >= mainMeasure(a2) && w2 >= w1 && mainMeasure(a1)-mainMeasure(a2) <= (w2-w1)/frequency)
   {
     objectsCollide = true;
     objectsCollisionTime = (mainMeasure(a1)-mainMeasure(a2)) / ((w2-w1)/frequency);
   }
   
   else if(mainMeasure(a1) <= mainMeasure(a2) && w2 <= w1 && mainMeasure(a1)-mainMeasure(a2) >= (w2-w1)/frequency)
   {
     objectsCollide = true;
     objectsCollisionTime = (mainMeasure(a1)-mainMeasure(a2)) / ((w2-w1)/frequency);
   }
   
   else
   {
     objectsCollide = false;
   }
 }
 
 else
 {
   if(mainMeasure(a1) >= wall && mainMeasure(a2) <= wall && w1 >= w2 && (2*PI - (mainMeasure(a1)-mainMeasure(a2))) <= (w1-w2)/frequency)
   {
     objectsCollide = true;
     objectsCollisionTime = (2*PI - (mainMeasure(a1)-mainMeasure(a2))) / ((w1-w2)/frequency);
   }
   
   else if(mainMeasure(a1) <= wall && mainMeasure(a2) >= wall && w2 >= w1 && (2*PI + (mainMeasure(a1) - mainMeasure(a2))) <= (w2-w1)/frequency)
   {
     objectsCollide = true;
     objectsCollisionTime = (2*PI + (mainMeasure(a1) - mainMeasure(a2))) / ((w2-w1)/frequency);
   }
   
   else
   {
     objectsCollide = false;
   }
 }
 
 
  
 objectsCollided = false;
 object1WallCollided = false;
 object2WallCollided = false;
 
 
 
 
 //Declaring objects new location and angular velocities according to collisions
 if(objectsCollide || object1WallCollide || object2WallCollide)
 {
  
  if(object1WallCollisionTime == min(object1WallCollisionTime, object2WallCollisionTime, objectsCollisionTime) && object1WallCollisionTime == object2WallCollisionTime)
  {
    a1 = wall;
    a2 = wall;
    w1 = -w1;
    w2 = -w2;
    object1WallCollided = true;
    object2WallCollided = true;
  }
   
  else if(object1WallCollisionTime == min(object1WallCollisionTime, object2WallCollisionTime, objectsCollisionTime))
  {
    a1 = wall;
    w1 = -w1;
    a2 = a2 + (w2*object1WallCollisionTime) / frequency;
    object1WallCollided = true;
  }
  
  else if(object2WallCollisionTime == min(object1WallCollisionTime, object2WallCollisionTime, objectsCollisionTime))
  {
    a2 = wall;
    w2 = -w2;
    a1 = a1 + (w1*object2WallCollisionTime) / frequency;
    object2WallCollided = true;
  }
  
  else if(objectsCollisionTime == min(object1WallCollisionTime, object2WallCollisionTime, objectsCollisionTime))
  {    
    a1 = a1 + (w1*objectsCollisionTime) / frequency;
    a2 = a1;
    float postVelocity[] = postCollision((I1 + (pow(I1,2)/I2)), (-2*momentum1*I1)/I2, (pow(momentum1,2)/I2) - 2*energy1, w1);
    w1 = postVelocity[0];
    w2 = postVelocity[1];
    objectsCollided = true;    
  }  
 }
 
 else
 {
   a1 = a1 + w1/frequency;
   a2 = a2 + w2/frequency;
 }
 
   
  object2WallCollisionTime = 2;
  object1WallCollisionTime = 2;
  objectsCollisionTime = 2;
 
 
  
  //Calculating objects coordinates according to their angle they make with (0,r) point 
  x1 = cos(a1)*r;
  y1 = sin(a1)*r;
  x2 = cos(a2)*r;
  y2 = sin(a2)*r;  
  
  
    
  translate(width/2,height/2);
  
  //Drawing the orbit
  stroke(c);
  fill(c);
  circle(0,0,2*r);  
  
  //Drawing the wall which has a length of wallLength*2
  stroke(w);
  strokeWeight(8);
  line(cos(wall)*(r-wallLength), sin(wall)*(r-wallLength), cos(wall)*(r+wallLength), sin(wall)*(r+wallLength));  
  
   
  //Drawing the objects 
  strokeWeight(0);
  fill(c1);
  circle(x1,y1,2*r1);
  
  fill(c2);
  circle(x2,y2,2*r2);  
  
  //Drawing objects line from (0,0) point to objects
  strokeWeight(4);
  stroke(c1);
  line(0,0,x1,y1);
  
  strokeWeight(4);
  stroke(c2);
  line(0,0,x2,y2);  
  


  println(frameCount);
  delay(time);
}




/**
 This method solves quadratic equation which is "a*w*w + b*w + c = 0"
 
 @param a: factor of w*w
 @param y: factor of w
 @param c: factor of pow(w,0)
 @param w: speed of the object
 @return: returns the speed after colliding which is not equal to the speed before colliding
*/

float discriminant(float a, float b, float c, float w){
      
  float delta = pow(b,2)-(4.0*a*c);
  float result1 = (-b + sqrt(delta))/(2.0*a);
  float result2 = (-b - sqrt(delta))/(2.0*a); 

  if(!equal(result1,w))
  {
    return result1;
  }
  
  else if(!equal(result2,w))
  {
    return result2;
  }
  
  else
  {
    throw new IllegalArgumentException("Discriminant error//No result existing");
  }
}


/**
 This method calculates angular velocities of objects after colliding
 
 @param a: parameter a of discriminant() method
 @param b: parameter b of discriminant() method
 @param c: parameter c of discriminant() method
 @param w: parameter w of discriminant() method (we take w as w1 and calculate w2_2 according to that so value of w should be entered as w1)  
 @return: returns a list which involves angular velocities of objects after colliding (firstObjectOfTheList: w1, secondObjectOfTheList: w2
*/

float[] postCollision(float a, float b, float c ,float w){
  
  float w1_2 = discriminant(a, b, c, w); 
  float w2_2 = (momentum1 - w1_2 * I1) / I2;
  float[] rtn = {w1_2,w2_2};  
  return rtn;
}


/**
 This method checks if two given floats are equal. There is an amount that can be tolerated.
 
 @param x: first float
 @param y: second float
 @return: true if they are equal
*/

boolean equal(float x, float y)
{
  final float tolerance = 0.01; //The difference between floats that can be tolerated
  
  if(abs(x-y) <= tolerance)
  {
    return true;
  }
  
  else
  {
    return false;
  }
}


/**
This method calculates an angle between 0 and 2*PI that is equivalent to the given angle

@param a: the angle that will be converted
@return: returns the equivalent angle in the range
*/

float mainMeasure(float a)
{
  float mod = a%(2*PI);
  
  if(mod >= 0)
  {
    return mod;
  }
  
  else
  {
    return mod+(2*PI);
  }
}
