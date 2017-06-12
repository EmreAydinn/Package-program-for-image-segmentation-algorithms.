function varargout = Segmentation(varargin)
% SEGMENTATION MATLAB code for Segmentation.fig
%      SEGMENTATION, by itself, creates a new SEGMENTATION or raises the existing
%      singleton*.
%
%      H = SEGMENTATION returns the handle to a new SEGMENTATION or the handle to
%      the existing singleton*.
%
%      SEGMENTATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEGMENTATION.M with the given input arguments.
%
%      SEGMENTATION('Property','Value',...) creates a new SEGMENTATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Segmentation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Segmentation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Segmentation

% Last Modified by GUIDE v2.5 04-May-2016 09:30:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Segmentation_OpeningFcn, ...
                   'gui_OutputFcn',  @Segmentation_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Segmentation is made visible.
function Segmentation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Segmentation (see VARARGIN)

% Choose default command line output for Segmentation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Segmentation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Segmentation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbuttonresimyukle.
function pushbuttonresimyukle_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonresimyukle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image
global filename
[filename,pathname]=uigetfile('*.jpg;*.tif;*.png;*.gif','All Image Files');
if filename==0
    msgbox(sprintf('Lütfen bir resim seçiniz'),'HATA','Error');
else
set(handles.popupmenu1,'Enable','on');
guidata(hObject,handles);

set(handles.pushbuttonsegmenteet,'Enable','on');
guidata(hObject,handles);

axes(handles.axes1)
filename = strcat(pathname,filename);
image =imread(filename);
imshow(image);
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

secimm = get(handles.popupmenu1,'Value');
switch secimm
    case 1
        set(handles.textdegisen,'Visible','off');
        set(handles.textdegisen2,'Visible','off');
        guidata(hObject,handles);
        set(handles.editdegerler,'Visible','off');
        set(handles.editdegerler2,'Visible','off');
        guidata(hObject,handles);
    case 2
        set(handles.textdegisen,'Visible','on');
        guidata(hObject,handles);
        set(handles.editdegerler,'Visible','on');
        guidata(hObject,handles);
        set(handles.textdegisen2,'Visible','off');
        guidata(hObject,handles);
        set(handles.editdegerler2,'Visible','off');
        guidata(hObject,handles);
         %set(handles.textdegisen,'String','K Küme sayýsýný girin:');
        guidata(hObject,handles);
    case 3
        set(handles.textdegisen,'Visible','off');
        guidata(hObject,handles);
        set(handles.editdegerler,'Visible','off');
        guidata(hObject,handles);
        set(handles.textdegisen2,'Visible','on');
        guidata(hObject,handles);
        set(handles.editdegerler2,'Visible','on');
        guidata(hObject,handles);
        %set(handles.textdegisen,'String','Ýterasyon sayýsýný girin:');
        guidata(hObject,handles);
    case 4
        set(handles.textdegisen,'Visible','off');
        guidata(hObject,handles);
        set(handles.editdegerler,'Visible','off');
        guidata(hObject,handles);
        set(handles.textdegisen2,'Visible','off');
        guidata(hObject,handles);
        set(handles.editdegerler2,'Visible','off');
        guidata(hObject,handles);
    case 5
        set(handles.textdegisen,'Visible','on');
        guidata(hObject,handles);
        set(handles.editdegerler,'Visible','on');
        guidata(hObject,handles);
        set(handles.textdegisen2,'Visible','on');
        guidata(hObject,handles);
        set(handles.editdegerler2,'Visible','on');
        guidata(hObject,handles);
        
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonsegmenteet.
function pushbuttonsegmenteet_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonsegmenteet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global secim
global filename
global image
secim = get(handles.popupmenu1,'Value');
switch secim
    case 1
       son_hali = Watershed2(filename);
       axes(handles.axes2);
       imshow(son_hali);
       axes(handles.axes1);
       imshow(image);
    case 2   
        try
            kume_sayisi = str2double(get(handles.editdegerler,'String'));
             if  kume_sayisi>15
                kume_sayisi = 15;
            end
            son_hali = renk_tabanli_k_means_algoritmasi(filename,kume_sayisi);
        catch
             msgbox(sprintf('lütfen 0 dan büyük bir sayý yazýnýz'),'HATA','Error');
        end
       axes(handles.axes2);
       imshow(son_hali);
       axes(handles.axes1);
       imshow(image);
    case 3
         try
            iterasyon_sayisi = str2double(get(handles.editdegerler2,'String'));
            if iterasyon_sayisi>2750
                iterasyon_sayisi = 2750;
            end
            
            son_hali  = region_seg_demo(filename,iterasyon_sayisi);
        catch
             msgbox(sprintf('lütfen 0 dan büyük bir sayý yazýnýz'),'HATA','Error');
        end
      
       axes (handles.axes2);
       imshow(son_hali);
       axes(handles.axes1);
       imshow(image);
       
    case 4
       son_hali =Split_and_Merge(filename);
       axes(handles.axes2);
       imshow(son_hali);
       axes(handles.axes1);
       imshow(image);
    case 5
        try
            iterasyon_sayisi = str2double(get(handles.editdegerler2,'String'));
            if iterasyon_sayisi>2750
                iterasyon_sayisi = 2750;
            end
            kume_sayisi = str2double(get(handles.editdegerler,'String'));
             if  kume_sayisi>15
                kume_sayisi = 15;
            end
           son_hali_k = renk_tabanli_k_means_algoritmasi(filename,kume_sayisi);
           son_hali_active = region_seg_demo(filename,iterasyon_sayisi);
        catch
             msgbox(sprintf('lütfen 0 dan büyük bir sayý yazýnýz'),'HATA','Error');
        end
        
        son_hali_wat = Watershed2(filename);
        son_hali_split = Split_and_Merge(filename);
        
        figure,
        subplot(2,2,4);imshow(son_hali_wat); title('Watershed');
        subplot(2,2,2); imshow(son_hali_k); title('K-Means'); 
        subplot(2,2,3); imshow(son_hali_active); title('Active Counter');
        subplot(2,2,1); imshow(son_hali_split); title('Split And Merge');
       
    otherwise
end 


% --- Executes on button press in pushbuttoncikis.
function pushbuttoncikis_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttoncikis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);
clear;



function editdegerler_Callback(hObject, eventdata, handles)
% hObject    handle to editdegerler (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editdegerler as text
%        str2double(get(hObject,'String')) returns contents of editdegerler as a double


% --- Executes during object creation, after setting all properties.
function editdegerler_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editdegerler (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editdegerler2_Callback(hObject, eventdata, handles)
% hObject    handle to editdegerler2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editdegerler2 as text
%        str2double(get(hObject,'String')) returns contents of editdegerler2 as a double


% --- Executes during object creation, after setting all properties.
function editdegerler2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editdegerler2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
