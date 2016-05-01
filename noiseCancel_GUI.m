function varargout = noiseCancel_GUI(varargin)
% NOISECANCEL_GUI MATLAB code for noiseCancel_GUI.fig
%      NOISECANCEL_GUI, by itself, creates a new NOISECANCEL_GUI or raises the existing
%      singleton*.
%
%      H = NOISECANCEL_GUI returns the handle to a new NOISECANCEL_GUI or the handle to
%      the existing singleton*.
%
%      NOISECANCEL_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NOISECANCEL_GUI.M with the given input arguments.
%
%      NOISECANCEL_GUI('Property','Value',...) creates a new NOISECANCEL_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before noiseCancel_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to noiseCancel_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help noiseCancel_GUI

% Last Modified by GUIDE v2.5 30-Apr-2016 22:21:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @noiseCancel_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @noiseCancel_GUI_OutputFcn, ...
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


% --- Executes just before noiseCancel_GUI is made visible.
function noiseCancel_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to noiseCancel_GUI (see VARARGIN)

% Choose default command line output for noiseCancel_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% generate initial noise to be used throughout program
% and plot initial conditions
n = generateNoise;
save('noise_saveFile','n');
noiseCancelF(handles,load('noise_saveFile','n'),false,'');

% UIWAIT makes noiseCancel_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = noiseCancel_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in songOnly_btn.
function songOnly_btn_Callback(hObject, eventdata, handles)
% hObject    handle to songOnly_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n = load('noise_saveFile','n');
noiseCancelF(handles,n,true,'song');

% --- Executes on button press in cancelled_btn.
function cancelled_btn_Callback(hObject, eventdata, handles)
% hObject    handle to cancelled_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n = load('noise_saveFile','n');
noiseCancelF(handles,n,true,'noiseCancelled');

% --- Executes on button press in noiseOnly_btn.
function noiseOnly_btn_Callback(hObject, eventdata, handles)
% hObject    handle to noiseOnly_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n = load('noise_saveFile','n');
noiseCancelF(handles,n,true,'noise');

% --- Executes on slider movement.
function NRI_slider_Callback(hObject, eventdata, handles)
% hObject    handle to NRI_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.NRI_text.String = num2str(handles.NRI_slider.Value);
n = load('noise_saveFile','n');
noiseCancelF(handles,n,false,'');

% --- Executes during object creation, after setting all properties.
function NRI_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NRI_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function NRI_text_Callback(hObject, eventdata, handles)
% hObject    handle to NRI_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NRI_text as text
%        str2double(get(hObject,'String')) returns contents of NRI_text as a double


% --- Executes during object creation, after setting all properties.
function NRI_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NRI_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in songAndNoise_btn.
function songAndNoise_btn_Callback(hObject, eventdata, handles)
% hObject    handle to songAndNoise_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n = load('noise_saveFile','n');
noiseCancelF(handles,n,true,'songAndNoise');
