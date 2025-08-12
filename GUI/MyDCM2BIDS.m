function varargout = MyDCM2BIDS(varargin)
% MYDCM2BIDS MATLAB code for MyDCM2BIDS.fig
%      MYDCM2BIDS, by itself, creates a new MYDCM2BIDS or raises the existing
%      singleton*.
%
%      H = MYDCM2BIDS returns the handle to a new MYDCM2BIDS or the handle to
%      the existing singleton*.
%
%      MYDCM2BIDS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYDCM2BIDS.M with the given input arguments.
%
%      MYDCM2BIDS('Property','Value',...) creates a new MYDCM2BIDS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MyDCM2BIDS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MyDCM2BIDS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MyDCM2BIDS

% Last Modified by GUIDE v2.5 08-Feb-2022 16:41:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MyDCM2BIDS_OpeningFcn, ...
    'gui_OutputFcn',  @MyDCM2BIDS_OutputFcn, ...
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


% --- Executes just before MyDCM2BIDS is made visible.
function MyDCM2BIDS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MyDCM2BIDS (see VARARGIN)

% Choose default command line output for MyDCM2BIDS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MyDCM2BIDS wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --------------INSERT LOGO-------------------------------------------%
% TODO - Define the filename based on root folder
% Get the full filename, with path prepended.
fullFileName = '/Users/brunorobalo/Documents/PMC/09. MRI pipelines/MyDCM2BIDS/Logo/LogoWithCop.png';
% Check for existence. Warn user if not found.
if ~exist(fullFileName, 'file')
    % Didn't find it there. Check the search path for it.
    fullFileName = baseFileName; % No path this time.
    if ~exist(fullFileName, 'file')
        % Still didn't find it. Alert user.
        errorMessage = sprintf('Error: %s does not exist.', fullFileName);
        uiwait(warndlg(errorMessage));
    end
else
    % Read it in from disk.
    rgbImage = imread(fullFileName);
    % Display the original color image.
    axes(handles.figure1);
    imshow(rgbImage, []);
end
% --------------END INSERT LOGO----------------------------------------%

% --- Outputs from this function are returned to the command line.
function varargout = MyDCM2BIDS_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function file_menu_Callback(hObject, eventdata, handles)
% hObject    handle to file_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function convert_menu_Callback(hObject, eventdata, handles)
% hObject    handle to convert_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function bids_menu_Callback(hObject, eventdata, handles)
% hObject    handle to bids_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_bids_nii2bids_Callback(hObject, eventdata, handles)
% hObject    handle to menu_bids_nii2bids (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_convert_zip_Callback(hObject, eventdata, handles)
% hObject    handle to menu_convert_zip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------UNZIP-----------------------------
function menu_convert_unzip_Callback(hObject, eventdata, handles)
% hObject    handle to menu_convert_unzip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
%Unzips files using matlab unzip or mac unzip (faster)

% Ask user for the root Dicom Zipped folders

current_dir = pwd;
zipped_root = uigetdir(current_dir,'Select Root folder with zipped Dicoms'); % dicom root folder
if zipped_root %only do this if user selects a zipped root folder
    [file,path,indx] = uigetfile('*.csv', 'Select "Koppelijst" file with PMC ID information');

    zippedFiles=dir(fullfile(zipped_root, '*.zip'));
    nozip=0;
    if ~isempty(zippedFiles)
        zippedFilesNames={zippedFiles.name}';
        zippedFilesFolders={zippedFiles.folder}';

        % unzip the first root folder
        for nzip=1:length(zippedFiles)
            temp_zip_name = fullfile(zippedFilesFolders{nzip},zippedFilesNames{nzip});
            % find ./ -name \*.zip -exec unzip {} \;
            xcmd = ['unzip ','"', temp_zip_name, '"'];
            [status,result] = system(xcmd);
        end
    end
end

% --------------------------------------------------------------------
function menu_convert_dcm2niix_Callback(hObject, eventdata, handles)
% hObject    handle to menu_convert_dcm2niix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_file_open_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_file_close_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_file_save_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
