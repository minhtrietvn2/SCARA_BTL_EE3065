function draw_axis(P, N)
quiver3(P(1)*[1 1 1],P(2)*[1 1 1],P(3)*[1 1 1],[N(1,1) 0 0],[N(2,1) 0 0],[N(3,1) 0 0],200,'LineWidth',1,'Color','r')
quiver3(P(1)*[1 1 1],P(2)*[1 1 1],P(3)*[1 1 1],[N(1,2) 0 0],[N(2,2) 0 0],[N(3,2) 0 0],200,'LineWidth',1,'Color','g')
quiver3(P(1)*[1 1 1],P(2)*[1 1 1],P(3)*[1 1 1],[N(1,3) 0 0],[N(2,3) 0 0],[N(3,3) 0 0],100,'LineWidth',1,'Color','b')
text(P(1)+N(1,1)*200,P(2)+N(2,1)*200,P(3),'x','Color','r')
text(P(1)+N(1,2)*200,P(2)+N(2,2)*200,P(3),'y','Color','g')
text(P(1)+N(1,3)*200,P(2)+N(2,3)*200,P(3)+N(3,3)*100,'z','Color','b')