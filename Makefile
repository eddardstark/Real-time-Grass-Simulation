MAIN = Grass
SHAREDPATH = GLTools/src/
SHAREDINCPATH = GLTools/include/
LIBDIRS = -L/usr/X11R6/lib -L/usr/X11R6/lib64 -L/usr/local/lib
INCDIRS = -I/usr/include -I/usr/local/include -I/usr/include/GL -I$(SHAREDINCPATH)  -I$(SHAREDINCPATH)GL

CC = g++
CXXFLAGS = $(COMPILERFLAGS) -g $(INCDIRS)
LIBS = -lX11  -lglut -lGL -lGLU -lm

prog : $(MAIN)

$(MAIN).o  		: $(MAIN).cpp
glew.o    		: $(SHAREDPATH)glew.c
fatal.o                 : fatal.c CSCIx229.h
loadtexbmp.o            : loadtexbmp.c CSCIx229.h
print.o                 : print.c CSCIx229.h
project.o               : project.c CSCIx229.h
errcheck.o              : errcheck.c CSCIx229.h
object.o    		: object.c CSCIx229.h
GLTools.o    		: $(SHAREDPATH)GLTools.cpp
GLBatch.o    		: $(SHAREDPATH)GLBatch.cpp
GLTriangleBatch.o    	: $(SHAREDPATH)GLTriangleBatch.cpp
GLShaderManager.o    	: $(SHAREDPATH)GLShaderManager.cpp
math3d.o    		: $(SHAREDPATH)math3d.cpp

$(MAIN) : $(MAIN).o glew.o
	$(CC) $(CXXFLAGS) -o $(MAIN) $(LIBDIRS) $(MAIN).cpp object.c loadtexbmp.c fatal.c print.c project.c errcheck.c $(SHAREDPATH)glew.c $(SHAREDPATH)GLTools.cpp $(SHAREDPATH)GLBatch.cpp $(SHAREDPATH)GLTriangleBatch.cpp $(SHAREDPATH)GLShaderManager.cpp $(SHAREDPATH)math3d.cpp $(LIBS)

clean:
	rm -f $(MAIN) *.o
