 function varargout = UTS(varargin)
% UTS MATLAB code for UTS.fig
%      UTS, by itself, creates a new UTS or raises the existing
%      singleton*. 
%
%      H = UTS returns the handle to a new UTS or the handle to
%      the existing singleton*.
%
%      UTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UTS.M with the given input arguments.
%
%      UTS('Property','Value',...) creates a new UTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UTS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UTS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UTS

% Last Modified by GUIDE v2.5 08-May-2021 03:05:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UTS_OpeningFcn, ...
                   'gui_OutputFcn',  @UTS_OutputFcn, ...
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


% --- Executes just before UTS is made visible.
function UTS_OpeningFcn(hObject, eventdata, handles, varargin)

%Menambah background
handles.output = hObject;
guidata(hObject, handles);
background=axes('unit', 'normalized', 'position', [0 0 1 1]);
bg=imread('2bg.jpg'); imagesc(bg);
set(background, 'handlevisibility','off','visible', 'off')



% --- Outputs from this function are returned to the command line.
function varargout = UTS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over judul.
function judul_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to judul (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in binner.
function binner_Callback(hObject, eventdata, handles)
% hObject    handle to binner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G;
axes(handles.axes2); %akses axes2
G = im2bw(G); %fungsi untuk merubah jd binner
guidata(hObject,handles);
imshow(G,[]); %menampilkan G dg array agar dapat dilakukan perubahan efek scr langsung setelah citra terakhir ditampilkan di axes2
axes(handles.axes4); %akses axes4
histogramRGB(G); %menampilkan histogram citra G

% --- Executes on button press in GrayScale.
function GrayScale_Callback(hObject, eventdata, handles)
% hObject    handle to GrayScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G;
axes(handles.axes2); %akses axes2
G = rgb2gray(G); %fungsi untuk merubah jd grayscale
guidata(hObject,handles); 
imshow(G,[]); %menampilkan G dengan array agar dapat dilakukan perubahan efek scr langsung setelah citra terakhir ditampilkan di axes2
axes(handles.axes4); %akses axes4
histogramRGB(G); %menampilkan histogram citra G


% --- Executes on button press in browserimage.
function browserimage_Callback(hObject, eventdata, handles)
% hObject    handle to browserimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
global G;
[nama , alamat] = uigetfile({'*.jpg';'*.bmp';'*.png';'*.tif'},'Browse Image'); %mengambil data
I = imread([alamat,nama]); %membaca data yg dipilih
handles.image=I; %gambar terpilih disimpan ke I
guidata(hObject, handles); %mengarahkan gcbo ke objek yg fungsinya sedang di eksekusi
axes(handles.axes1); %akses akses1
imshow(I,[]); %menampilkan gambar
G=I; %menyimpan data I ke G, jd isinya sama G dg I, nanti G yang berubah karena image processingnya
axes(handles.axes3); %akses axes3 buat histogram asal
histogramRGB(G); %nampil fungsi histogramRGB



% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G;
[nama, alamat] = uiputfile({'*.png','PNG (*.PNG)';'*.jpg','JPG (*.jpg)'},'Save Image');
imwrite(G,fullfile(alamat,nama));
guidata(hObject, handles);

% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G;
global I;
citra=handles.image; 
axes(handles.axes2);
cla;
imshow(citra); %membuat citra asli blm terkena filter tetap ada

cla reset;
G=I;


% --- Executes on button press in btnred.
function btnred_Callback(hObject, eventdata, handles)
% hObject    handle to btnred (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global G;
axes(handles.axes2);
red = G(:,:,1); % Red channel
% Create an all black channel.
var = zeros(size(G, 1), size(G, 2), 'uint8');
% Create color versions of the individual color channels.
just_red = cat(3, red, var, var);
guidata(hObject,handles);
imshow(just_red);
axes(handles.axes4);
histogram(G(:),256,'FaceColor','r','EdgeColor','r')

% --- Executes on button press in btnblue.
function btnblue_Callback(hObject, eventdata, handles)
% hObject    handle to btnblue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global G;
axes(handles.axes2);
blue = G(:,:,3); % Blue channel
% Create an all black channel.
var = zeros(size(G, 1), size(G, 2), 'uint8');
% Create color versions of the individual color channels.
just_blue = cat(3, var, var, blue);
guidata(hObject,handles);
imshow(just_blue);
axes(handles.axes4);
%histogramRGB(G);
histogram(G(:),256,'FaceColor','b','EdgeColor','b')



% --- Executes on button press in btngreen.
function btngreen_Callback(hObject, eventdata, handles)
% hObject    handle to btngreen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global G;
axes(handles.axes2);
green = G(:,:,2); % Green channel
% Create an all black channel.
var = zeros(size(G, 1), size(G, 2), 'uint8');
% Create color versions of the individual color channels.
just_green = cat(3, var, green, var);
guidata(hObject,handles);
imshow(just_green);
axes(handles.axes4);
%histogramRGB(G);
histogram(G(:),256,'FaceColor','g','EdgeColor','g')
