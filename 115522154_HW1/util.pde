public void CGLine(float x1, float y1, float x2, float y2, color c) {
    // TODO HW1
    // You need to implement the "line algorithm" in this section.
    // You can use the function line(x1, y1, x2, y2); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    // For instance: drawPoint(114, 514, color(255, 0, 0)); signifies drawing a red
    // point at (114, 514).
   
     /*
    stroke(255,0,0);
     noFill();
     line(x1,y1,x2,y2);
    */
    
     // 統一先四捨五入轉為整數像素座標
    int ix1 = Math.round(x1);
    int ix2 = Math.round(x2);
    int iy1 = Math.round(y1);
    int iy2 = Math.round(y2);
    if (ix1 == ix2 && iy1 == iy2) {
          drawPoint(ix1, iy1, c);
          return;
    }
    float dx = Math.abs(ix2 - ix1);
    float dy = Math.abs(iy2 - iy1);
    //判斷x,y誰移動較多
      if(dx >= dy){
         
        //先確保 x1 < x2
        if(ix1 > ix2){
          
          int tempx = ix1;
          ix1 = ix2;
          ix2 = tempx;
          int tempy = iy1;
          iy1 = iy2;
          iy2 = tempy;
        }
        float mx =(float) (iy2 - iy1) / (ix2 - ix1);
       
        for(int x = ix1; x <= ix2; x++ ){
          float y = iy1 + mx*(x - ix1);
          int iy = Math.round(y);
          drawPoint(x,iy,c);
        }
        
    }
     else if(dy >= dx){
       
      //4.逐漸增加y的情況
      if(iy1 > iy2){
         
          int tempx = ix1;
          ix1 = ix2;
          ix2 = tempx;
          int tempy = iy1;
          iy1 = iy2;
          iy2 = tempy;
        }
        float my =(float) (ix2 - ix1) / (iy2 - iy1);
      for(int y = iy1; y <= iy2; y++ ){
      float x = ix1 + my*(y - iy1);
      int ix = Math.round(x);
      drawPoint(ix,y,c);
      } 
    } 
}

public void CGLine(float x1, float y1,
                   float x2, float y2) {
    CGLine(x1, y1, x2, y2, color(0));
}

public void CGCircle(float x, float y, float r, color c) {
    // TODO HW1
    // You need to implement the "circle algorithm" in this section.
    // You can use the function circle(x, y, r); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    /*
    stroke(0);
    noFill();
    circle(x,y,r*2);
    */
    
    int radius = round(r); //避免r為float狀況
    float dx = 0;
    float dy = radius;
    float p = 1 - radius; //決策函數
    while(dx <= dy){
      drawPoint(x + dx, y + dy, c);
      drawPoint(x + dx, y - dy, c);
      drawPoint(x - dx, y + dy, c);
      drawPoint(x - dx, y - dy, c);
      //相對點
      drawPoint(x + dy, y + dx, c);
      drawPoint(x + dy, y - dx, c);
      drawPoint(x - dy, y + dx, c);
      drawPoint(x - dy, y - dx, c);
      
      //判斷下個點往右or右下
      if(p < 0){
        p = (p + 2*dx + 3);
        dx++;
      }
      else{
        p = (p + 2*dx - 2*dy + 5);
        dx++;
        dy--;
      }
    }
        
}

public void CGCircle(float x, float y, float r) {
    CGCircle(x, y, r, color(0));
}

public void CGEllipse(float x, float y, float r1, float r2, color c) {
    // TODO HW1
    // You need to implement the "ellipse algorithm" in this section.
    // You can use the function ellipse(x, y, r1,r2); to verify the correct answer.
    // However, remember to comment out the function before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    /*
    stroke(0);
    noFill();
    ellipse(x,y,r1*2,r2*2);
    */
    //midpoint ellipse algorithm
    //region1
    float dx = 0;
    float dy = r2;
    float p1 = (r2 * r2) - (r1 * r1 * r2) + (0.25f * r1 * r1 );

    while (r2*r2*dx < r1*r1*dy) {
        // 四向對稱
        drawPoint(x + dx, y + dy, c);
        drawPoint(x + dx, y - dy, c);
        drawPoint(x - dx, y + dy, c);
        drawPoint(x - dx, y - dy, c);
        //選 E 或 SE
        if(p1 < 0){
          p1 = p1 + r2 * r2 * (2 * dx + 3);
          //座標更新
          dx++;
        }
        else{
          p1 = p1 + r2 * r2 * (2 * dx + 3) + r1 * r1 * (-2 * dy + 2);
          //座標更新
          dx++;
          dy--;
        }
    }

    //region2
  
    float p2 = (r2 * r2) * (dx + 0.5f) * (dx + 0.5f)+ r1 * r1 *(dy - 1) * (dy - 1) - r1 * r1 * r2 * r2;

    while (dy >= 0) {
        // 四向對稱 drawPoint()
       drawPoint(x + dx, y + dy, c);
        drawPoint(x + dx, y - dy, c);
        drawPoint(x - dx, y + dy, c);
        drawPoint(x - dx, y - dy, c);
    
        if (p2 > 0) {
            p2 = p2 + r1*r1*(-2*dy+3);
            // 座標更新
            dy--;     
        } else {
            p2 = p2 + (r2*r2)*(2*dx+2)+(r1*r1)*(-2*dy+3) ;
            // 座標更新
            dx++;
            dy--;
         }
    }
    
}

public void CGEllipse(float x, float y, float r1, float r2) {
    CGEllipse(x, y, r1, r2, color(0));
}

public void CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4, color c) {
    // TODO HW1
    // You need to implement the "bezier curve algorithm" in this section.
    // You can use the function bezier(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x,
    // p4.y); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    /*
    stroke(0);
    noFill();
    bezier(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y);
    */
    int s = 1000;
    for(int i = 0; i <= s; i++){
      float t = (float)i / s;
      float u = 1.0f - t;
      float px = u * u * u * p1.x + 3 * u * u * t * p2.x + 3 * u * t * t * p3.x + t * t * t * p4.x;
      float py = u * u * u * p1.y + 3 * u * u * t * p2.y + 3 * u * t * t * p3.y + t * t * t * p4.y;
      drawPoint(px, py, c);
    }
    
}

public void CGCurve(Vector3 p1, Vector3 p2,
                    Vector3 p3, Vector3 p4) {
    CGCurve(p1, p2, p3, p4, color(0));
}

public void CGEraser(Vector3 p1, Vector3 p2) {
    // TODO HW1
    // You need to erase the scene in the area defined by points p1 and p2 in this
    // section.
    // p1 ------
    // |       |
    // |       |
    // ------ p2
    // The background color is color(250);
    // You can use the mouse wheel to change the eraser range.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    
   

    int left   = floor(min(p1.x, p2.x));
    int right  = ceil(max(p1.x, p2.x));
    int top    = floor(min(p1.y, p2.y));
    int bottom = ceil(max(p1.y, p2.y));

    for (int i = left; i <= right; i++) {
        for (int j = top; j <= bottom; j++) {
            drawPoint(i, j, color(250));
        }
    }


}

public void drawPoint(float x, float y, color c) {
    stroke(c);
    point(x, y);
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}
