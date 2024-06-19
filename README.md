# Latex_model

This repository aims at creating models for Latex projects for different types of files.

- It produces a pdf file from the main.text file in the folder you select.
- Please name the main text file of your project as "main.tex".
- This file uses MyStyleSheet.sty to import packages and custom functions, then it takes images from the image folder and pages from the text folder.
- The resulting pdf will be name after the parent directory's name and placed in the same folder as main.tex.

To compile, you can use the run.bat file on Windows. Here is an example:

```cmd
.\run.bat .\Article
```

This repository can be the root folder of your Latex projects and you can create private repositories inside this one to use only one .sty and one .bat file for all your projects. Be careful not to push YourProject/build/.

## Syntax tips

Latex doesn't like hyphens so name your images with underscores instead of hyphens and use {-} to display a hyphen inside your document. This will prevent the warning to be displayed.  
In the same way, use {} at the end of a command with no parameter to have no warning.

## Debug tips

If an error keeps blocking compilation but the error has actually been corrected, delete the build folder and recompute again. It does't do it by default because otherwise, it would recreate everything each time and it would take more time.
