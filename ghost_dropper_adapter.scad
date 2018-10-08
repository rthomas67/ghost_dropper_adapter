// crank brothers - ghost kato 
// internal dropper seatpost cable-routing adapter

insertWidth=21;
insertHeight=17;
insertDepth=15;

// bulge/curve in the middle of each side
insertBulgeRadius=5;
insertBulgeX=0.25; // left and right (relative to the bike seat post)
insertBulgeY=0.25; // top and bottom (relative to the bike seat post)

cableJacketOpeningDia=4.75;
cableJacketXOffset=insertWidth/2;
cableJacketYOffset=16;
cableJacketZOffset=1.5;
cableJacketXAngle=42;
cableJacketYAngle=0;

topOpeningOpeningDia=insertWidth-2;
topOpeningXOffset=insertWidth/2;
topOpeningYOffset=19;
topOpeningZOffset=-5;
topOpeningXAngle=-60;

innerBottomInset=2;  // how much the hole narrows across the bottom (bike-wise)
innerSideInset=2;

insertCornerRoundnessRadius=3;

$fn=50;


//  %bodyCrudeAttempt();
//  %cube([insertWidth,insertHeight,insertDepth]);  // for reference
difference() {
    bodyUsingHull();
    // cable thru-hole
    translate([cableJacketXOffset,cableJacketYOffset,cableJacketZOffset])
        rotate([cableJacketXAngle,cableJacketYAngle,0])
            cylinder(d=cableJacketOpeningDia, h=insertDepth*3);
    // top opening matching cut
    translate([topOpeningXOffset,topOpeningYOffset,topOpeningZOffset])
        rotate([topOpeningXAngle,0,0])
            translate([0,0,-insertDepth*3/2])
            cylinder(d=topOpeningOpeningDia, h=insertDepth*3);
    

}

module bodyUsingHull() {
    hull() {
        // corners
        // inner end of insert (against axes)
        // 0,0
        translate([insertCornerRoundnessRadius+innerSideInset,insertCornerRoundnessRadius+innerBottomInset,0])
            cylinder(r=insertCornerRoundnessRadius, h=1);
        // 0,y
        translate([insertCornerRoundnessRadius,insertHeight-insertCornerRoundnessRadius,0])
            cylinder(r=insertCornerRoundnessRadius, h=1);
        // x,0
        translate([insertWidth-insertCornerRoundnessRadius-innerSideInset,
                insertCornerRoundnessRadius+innerBottomInset,0])
            cylinder(r=insertCornerRoundnessRadius, h=1);
        // x,y
        translate([insertWidth-insertCornerRoundnessRadius,insertHeight-insertCornerRoundnessRadius,0])
            cylinder(r=insertCornerRoundnessRadius, h=1);

        // outer (facing) end of insert (+z / top of drawing)
        // 0,0
        translate([insertCornerRoundnessRadius,insertCornerRoundnessRadius,insertDepth-1])
            cylinder(r=insertCornerRoundnessRadius, h=1);
        // 0,y
        translate([insertCornerRoundnessRadius,insertHeight-insertCornerRoundnessRadius,insertDepth-1])
            cylinder(r=insertCornerRoundnessRadius, h=1);
        // x,0
        translate([insertWidth-insertCornerRoundnessRadius,insertCornerRoundnessRadius,insertDepth-1])
            cylinder(r=insertCornerRoundnessRadius, h=1);
        // x,y
        translate([insertWidth-insertCornerRoundnessRadius,insertHeight-insertCornerRoundnessRadius,insertDepth-1])
            cylinder(r=insertCornerRoundnessRadius, h=1);
        
        // bulges
        // inner end of insert (against axes)
        xCenter=insertWidth/2;
        yCenter=insertHeight/2;
        // x bottom
        translate([xCenter,insertBulgeRadius-insertBulgeY+innerBottomInset,0])
            cylinder(r=insertBulgeRadius, h=1);
        // x top
        translate([xCenter,insertHeight-insertBulgeRadius+insertBulgeY,0])
            cylinder(r=insertBulgeRadius, h=1);
        // y left
        translate([insertBulgeRadius-insertBulgeX+innerSideInset,yCenter,0])
            cylinder(r=insertBulgeRadius, h=1);
        // y right
        translate([insertWidth-insertBulgeRadius-innerSideInset+insertBulgeX,yCenter,0])
            cylinder(r=insertBulgeRadius, h=1);

        // outer (facing) end of insert (+z / top of drawing)
        // x bottom
        translate([xCenter,insertBulgeRadius-insertBulgeY,insertDepth-1])
            cylinder(r=insertBulgeRadius, h=1);
        // x top
        translate([xCenter,insertHeight-insertBulgeRadius+insertBulgeY,insertDepth-1])
            cylinder(r=insertBulgeRadius, h=1);
        // y left
        translate([insertBulgeRadius-insertBulgeX,yCenter,insertDepth-1])
            cylinder(r=insertBulgeRadius, h=1);
        // y right
        translate([insertWidth-insertBulgeRadius+insertBulgeX,yCenter,insertDepth-1])
            cylinder(r=insertBulgeRadius, h=1);
    }
    
}

module bodyCrudeAttempt() {
        translate([insertCornerRoundnessRadius,insertCornerRoundnessRadius,0]) {
        linear_extrude(height=insertDepth) {
            minkowski() {
                square([insertWidth-insertCornerRoundnessRadius*2,insertHeight-insertCornerRoundnessRadius*2]);
                circle(r=insertCornerRoundnessRadius);
            }
        }
    }
}