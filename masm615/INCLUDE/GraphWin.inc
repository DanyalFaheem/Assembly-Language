.NOLIST
; GraphWin.inc - Include file for Graphics Windows Application
; By Kip Irvine and Tom Joyce.
; Most of the definitions found here are from three header files:
; WinUser.h, WinBase.h, and Winnt.h

; Last update: 11/10/02  (Removed GetLastError)

;------------------ Structures ----------------

POINT STRUCT
  X   DWORD ?
  Y   DWORD ?
POINT ENDS

RECT STRUCT
  left      DWORD ?
  top       DWORD ?
  right     DWORD ?
  bottom    DWORD ?
RECT ENDS

MSGStruct STRUCT
  msgWnd        DWORD ?
  msgMessage    DWORD ?
  msgWparam     DWORD ?
  msgLparam     DWORD ?
  msgTime       DWORD ?
  msgPt         POINT <>
MSGStruct ENDS

WNDCLASS STRUC
  style           DWORD ?
  lpfnWndProc     DWORD ?
  cbClsExtra      DWORD ?
  cbWndExtra      DWORD ?
  hInstance       DWORD ?
  hIcon           DWORD ?
  hCursor         DWORD ?
  hbrBackground   DWORD ?
  lpszMenuName    DWORD ?
  lpszClassName   DWORD ?
WNDCLASS ENDS

;-------------- Function Prototypes ------------------------

CreateWindowExA PROTO,	; create and register a window class
	exWinStyle:DWORD,
	className:PTR BYTE,
	winName:PTR BYTE,
	winStyle:DWORD,
	X:DWORD,
	Y:DWORD,
	rWidth:DWORD,
	rHeight:DWORD,
	hWndParent:DWORD,
	hMenu:DWORD,
	hInstance:DWORD,
	lpParam:DWORD

DefWindowProcA PROTO,	; default Windows message handler
	hWnd:DWORD,
	locMsg:DWORD,
	wParam:DWORD,
	lParam:DWORD

DispatchMessageA PROTO,	; dispatch a message to the application
	pMsg:PTR BYTE

ExitProcess PROTO,	; exit the current process
	exitCode:DWORD

FormatMessageA PROTO,	; format a message
	dwFlags:DWORD,
	lpSource:DWORD,
	msgID:DWORD,
	languageID:DWORD,
	lpBuffer:PTR BYTE,
	nSize:DWORD,
	pArgs:DWORD

GetMessageA PROTO,
	lpMsg:PTR BYTE,
	hWnd:DWORD,
	firstMsg:DWORD,
	lastMsg:DWORD

GetModuleHandleA PROTO,
	pString:PTR BYTE

GetWindowDC PROTO,	; get the current window's device context
	hWind:DWORD

GetWindowRect PROTO,	; get the current window's rectangle
	hWind:DWORD,
	pRect:PTR RECT

LoadCursorA PROTO,	; load a cursor resource
	hInstance:DWORD,
	pString:PTR BYTE

LoadIconA PROTO,	; loan an icon resource
	hInstance:DWORD,
	pString:PTR BYTE

LocalFree PROTO,	; free up local memory, using its handle
	hMem:DWORD

MessageBoxA PROTO,	; display a pop-up message box
	hWnd:DWORD,
	lpText:PTR BYTE,
	lpCaption:PTR BYTE,
	style:DWORD

PostQuitMessage PROTO,	; tell Windows to terminate the app
	exitCode:DWORD

RegisterClassA PROTO,	; register a new window class
	pWndClass:PTR WNDCLASS

ShowWindow PROTO,	; show a window
	hWnd:DWORD,
	showState:DWORD

UpdateWindow PROTO,	; draw(redraw) a window
	hWnd:DWORD

Comment !
SelectObject PROTO,	; GDI32.LIB
	hdc:DWORD
	hGDIobject:DWORD
DeleteObject PROTO,	; GDI32.LIB
	hGDIobject:DWORD
!

; Redefine Win32 Names to standard API names.
GetModuleHandle TEXTEQU <GetModuleHandleA>
LoadCursor      TEXTEQU <LoadCursorA>
LoadIcon        TEXTEQU <LoadIconA>
RegisterClass   TEXTEQU <RegisterClassA>
CreateWindowEx  TEXTEQU <CreateWindowExA>
DispatchMessage TEXTEQU <DispatchMessageA>
GetMessage      TEXTEQU <GetMessageA>
DefWindowProc   TEXTEQU <DefWindowProcA>
FormatMessage   TEXTEQU <FormatMessageA>
MessageBox      TEXTEQU <MessageBoxA>

; RegisterClass Constants (from Winuser.h)
COLOR_WINDOW        = 5		; std window color
COLOR_BACKGROUND    = 2		; 2=blue F=gray
IDI_APPLICATION     = 32512		; application icon
IDC_ARROW           = 07f00h		; mouse cursor--arrow
CW_USEDEFAULT       = 80000000h		; default window size & position

; Window Style Constants
WS_OVERLAPPED       =     00000000h
WS_BORDER           =     00800000h
WS_DLGFRAME         =     00400000h
WS_SYSMENU          =     00080000h
WS_MAXIMIZEBOX      =     00010000h
WS_MINIMIZEBOX      =     00020000h
WS_THICKFRAME       =     00040000h
WS_CAPTION          =     WS_BORDER+WS_DLGFRAME
WS_VISIBLE          =     10000000h

; Window show constants
SW_SHOW             =     05h

; Error Handler Variables
FORMAT_MESSAGE_ALLOCATE_BUFFER     = 100h
FORMAT_MESSAGE_FROM_SYSTEM         = 1000h

; Window Messages
WM_CLOSE            =  0010h		; close window
WM_CREATE           =  01h		; create window
WM_LBUTTONDOWN      =  0201h		; left mouse button down

;MB_ICONERROR  =  010h	; stop sign icon
MB_ICONHAND            = 10h
MB_ICONQUESTION        = 20h
MB_ICONEXCLAMATION     = 30h
MB_ICONASTERISK        = 40h

MB_USERICON            = 80h
MB_ICONWARNING         = MB_ICONEXCLAMATION
MB_ICONERROR           = MB_ICONHAND
MB_ICONINFORMATION     = MB_ICONASTERISK
MB_ICONSTOP            = MB_ICONHAND

; Message Box Buttons
MB_OK         = 0
MB_OKCANCEL   = 1
MB_ABORTRETRYIGNORE = 2
MB_YESNOCANCEL = 3
MB_YESNO       = 4
MB_RETRYCANCEL = 5
MB_CANCELTRYCONTINUE = 6

;Constants created by Irvine:
NULL EQU 0

MAIN_WINDOW_STYLE = WS_VISIBLE+WS_DLGFRAME+WS_CAPTION+WS_BORDER+WS_SYSMENU \
	+WS_MAXIMIZEBOX+WS_MINIMIZEBOX+WS_THICKFRAME

.LIST