function propout;
%BWS
%August 2000
%Cross-Section Properties Output Screen
%Add ability to export to mastan
%
%general
global fig screen prop node elem lengths curve shapes clas springs constraints GBTcon BC m_all neigs version screen
%output from pre2
global subfig ed_prop ed_node ed_elem ed_lengths axestop screen flags modeflag ed_springs ed_constraints
%output from template
global prop node elem lengths springs constraints h_tex b1_tex d1_tex q1_tex b2_tex d2_tex q2_tex r1_tex r2_tex r3_tex r4_tex t_tex C Z kipin Nmm axestemp subfig
%output from propout and loading
global A xcg zcg Ixx Izz Ixz thetap I11 I22 Cw J outfy_tex unsymm restrained Bas_Adv scale_w Xs Ys w scale_tex_w outPedit outMxxedit outMzzedit outM11edit outM22edit outTedit outBedit outL_Tedit outx_Tedit Pcheck Mxxcheck Mzzcheck M11check M22check Tcheck screen axesprop axesstres scale_tex maxstress_tex minstress_tex
%output from boundary condition (Bound. Cond.)
global ed_m ed_neigs solutiontype togglesignature togglegensolution popup_BC toggleSolution Plengths Pm_all Hlengths Hm_all subfig lengthindex axeslongtshape longitermindex txt_longterm len_cur len_longterm longshape_cur jScrollPane_edm jViewPort_edm jEditbox_edm hjScrollPane_edm
%output from cFSM
global toggleglobal toggledist togglelocal toggleother ed_global ed_dist ed_local ed_other NatBasis ModalBasis toggleCouple popup_load axesoutofplane axesinplane axes3d lengthindex modeindex spaceindex longitermindex b_v_view modename spacename check_3D cutface_edit len_cur mode_cur space_cur longterm_cur modes SurfPos scale twod threed undef scale_tex
%output from compareout
global pathname filename pathnamecell filenamecell propcell nodecell elemcell lengthscell curvecell clascell shapescell springscell constraintscell GBTconcell solutiontypecell BCcell m_allcell filedisplay files fileindex modes modeindex mmodes mmodeindex lengthindex axescurve togglelfvsmode togglelfvslength curveoption ifcheck3d minopt logopt threed undef len_plot lf_plot mode_plot SurfPos cutsurf_tex filename_plot len_cur scale_tex mode_cur mmode_cur file_cur xmin_tex xmax_tex ymin_tex ymax_tex filetoplot_tex screen popup_plot filename_title2 clasopt popup_classify times_classified toggleclassify classification_results plength_cur pfile_cur togglepfiles toggleplength mlengthindex mfileindex axespart_title axes2dshape axes3dshape axesparticipation axescurvemode  modedisplay modestoplot_tex
%
%
%
%defaults
scale_w=1;
%
%
%
%loading
subfig=figure;
name=['CUFSM v',version,' -- Properties of cross section'];
set(subfig,'Name',name,'NumberTitle','off');
set(subfig,'MenuBar','none');
set(subfig,'position',[50 70 900 500])%
%
%
%Define the axis for the cross-section plots
axesprop=axes('Units','normalized','Position',[0.45 0.03 0.55 0.85],'visible','off');
%
%
%
%calculate section properties
%[A,xcg,zcg,Ixx,Izz,Ixz,thetap,I11,I22]=grosprop(node,elem);
%[Cw, J, Xs, Ys, w, Bx, By, B1, B2]=Warp(node,elem);
[A,xcg,zcg,Ixx,Izz,Ixz,thetap,I11,I22,J,Xs,Ys,Cw,B1,B2,w] = cutwp_prop2(node(:,2:3),elem(:,2:4));
%
if isempty(A)&isempty(xcg)&isempty(zcg)&isempty(Ixx)&isempty(Izz)&isempty(Ixz)&isempty(thetap)&isempty(I11)&isempty(I22)&isempty(J)&isempty(Xs)&isempty(Ys)&isempty(Cw)&isempty(B1)&isempty(B2)&isempty(w)
    msgbox('Multiple sections in use. Unable to calculate the section properties','Multiple sections','help'),
    return;
else
    thetap=thetap*180/pi; %degrees...
    Bx=NaN;, By=NaN;
    %initial plot
    propplot(node,elem,xcg,zcg,thetap,axesprop)
    %
    %
    %SECTION PROPERTIES
    upperbox=uicontrol(subfig,...
        'Style','frame','units','normalized',...
        'HorizontalAlignment','Left',...
        'Position',[0.0 0.9 1.0 0.1]);
    upperlabel=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Center',...
        'FontName','Arial','FontSize',13,...
        'Position',[0.01 0.93 .98 0.05],...
        'String','Calculated Section Properties (Fully Composite Always Assumed)');
    
    %basic sectional properties
    upperframe=uicontrol(subfig,...
        'Style','frame','units','normalized',...
        'Position',[0.0 0.45 0.45 0.45]);
    outA=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Right',...
        'Position',[0.02 0.82 0.05 0.05],...
        'String','A = ');
    outJ=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Right',...
        'Position',[0.25 0.82 0.05 0.05],...
        'String','J = ');
    outxcg=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Right',...
        'Position',[0.02 0.74 0.05 0.05],...
        'String','xcg = ');
    outzcg=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Right',...
        'Position',[0.25 0.74 0.05 0.05],...
        'String','zcg = ');
    outIxx=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Right',...
        'Position',[0.02 0.66 0.05 0.05],...
        'String','Ixx = ');
    outIzz=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Right',...
        'Position',[0.25 0.66 0.05 0.05],...
        'String','Izz = ');
    outIxz=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Right',...
        'Position',[0.02 0.58 0.05 0.05],...
        'String','Ixz = ');
    outthetap=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Right',...
        'Position',[0.25 0.58 0.05 0.05],...
        'fontname','symbol',...
        'String',('q = '));
    outI11=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Right',...
        'Position',[0.02 0.50 0.05 0.05],...
        'String','I11 = ');
    outI22=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Right',...
        'Position',[0.25 0.50 0.05 0.05],...
        'String','I22 = ');
    out2A=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Left',...
        'Position',[0.07 0.82 0.12 0.05],...
        'String',num2str(A));
    out2J=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Left',...
        'Position',[0.3 0.82 0.12 0.05],...
        'String',num2str(J));
    out2xcg=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Left',...
        'Position',[0.07 0.74 0.12 0.05],...
        'String',num2str(xcg));
    out2zcg=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Left',...
        'Position',[0.3 0.74 0.12 0.05],...
        'String',num2str(zcg));
    out2Ixx=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Left',...
        'Position',[0.07 0.66 0.12 0.05],...
        'String',num2str(Ixx));
    out2Izz=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Left',...
        'Position',[0.3 0.66 0.12 0.05],...
        'String',num2str(Izz));
    out2Ixz=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Left',...
        'Position',[0.07 0.58 0.12 0.05],...
        'String',num2str(Ixz));
    out2thetap=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Left',...
        'Position',[0.3 0.58 0.12 0.05],...
        'String',num2str(thetap));
    out2I11=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Left',...
        'Position',[0.07 0.50 0.12 0.05],...
        'String',num2str(I11));
    out2I22=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Left',...
        'Position',[0.3 0.50 0.12 0.05],...
        'String',num2str(I22));
    %
    %
    %Additional Section properties
    %
    lowerframe=uicontrol(subfig,...
        'Style','frame','units','normalized',...
        'Position',[0.0 0.0 0.45 0.45]);
    
    out_open_prop=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Center',...
        'Position',[0.01 0.38 0.38 0.05],...
        'String','Open Section Properties');
    %
    outC_w=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Right',...
        'Position',[0.02 0.23 0.05 0.05],...
        'String','Cw = ');
    outX_s=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Right',...
        'Position',[0.02 0.3 0.05 0.05],...
        'String','Xs = ');
    outY_s=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Right',...
        'Position',[0.25 0.3 0.05 0.05],...
        'String','Zs = ');
    out2C_w=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Left',...
        'Position',[0.07 0.23 0.1 0.05],...
        'String',num2str(Cw));
    out2X_s=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Left',...
        'Position',[0.07 0.3 0.1 0.05],...
        'String',num2str(Xs));
    out2Y_s=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Left',...
        'Position',[0.3 0.3 0.1 0.05],...
        'String',num2str(Ys));
    
    % Beta properties from CUFSM 3, using CUTWP engine
    % errors corrected in CUTWP engine December 2006 - BWS
    %----------------------------------------------------
    outB1=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Right',...
        'Position',[0.02 0.15 0.05 0.05],...
        'fontname','symbol',...
        'String','b1 = ');
    outB2=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Right',...
        'Position',[0.02 0.05 0.05 0.05],...
        'fontname','symbol',...
        'String','b2 = ');
    out2B1=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Left',...
        'Position',[0.07 0.15 0.08 0.05],...
        'String',num2str(B1));
    out2B2=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Left',...
        'Position',[0.07 0.05 0.08 0.05],...
        'String',num2str(B2));
    %----------------------------------------------------
    
    
    Bas_Adv=uicontrol(subfig,...
        'Style','popupmenu','units','normalized',...
        'Position',[0.15 0.15 0.15 0.05],...
        'String',['Basic Plot   ';...
        'Warping Plot '],...
        'Value',1,...
        'Callback',[...
        'propout_cb(6);']);
    
    scaletitle_w=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Right',...
        'Position',[0.3 0.15 0.03 0.05],...
        'fontname','symbol',...
        'String','w');
    scaletitle_w=uicontrol(subfig,...
        'Style','text','units','normalized',...
        'HorizontalAlignment','Right',...
        'Position',[0.33 0.15 0.05 0.05],...
        'String',' scale  = ');
    scale_tex_w=uicontrol(subfig,...
        'Style','edit','units','normalized',...
        'Position',[0.38 0.15 0.05 0.05],...
        'String',num2str(scale_w));
    save_textfile_w=uicontrol(subfig,...
        'Style','push','units','normalized',...
        'Position',[0.18 0.04 0.25 0.08],...
        'String','warping text out',...
        'Callback',[...
        'propout_cb(7);']);
    %
    %
    %%Export to Mastan button removed in v5.05 as updates are needed to
    %%keep up with changes made on the mastan side.
    % export_2_mastan=uicontrol(subfig,...
    %     'Style','push','units','normalized',...
    %     'Position',[0.84 0.91 0.15 0.08],...
    %     'String','Export Section to MASTAN',...
    %     'Callback',[...
    %     'propout_cb(100);']);

end