# Latex_model

[See video on how to install Latex](https://www.youtube.com/watch?v=4lyHIQl4VM8)

This repository aims at creating models for Latex projects for different types of files.

- It produces a pdf file from the main.text file in the folder you select.
- Please name the main text file of your project as "main.tex".
- These files use MyStyleSheet.sty to import packages and custom functions, then they take images from their image folder and pages from their text folder.
- The resulting pdf will be named after the parent directory's name and placed in .\<your_folder>.\pdf_output\

To compile, you can use the run.bat file on Windows. Here is an example:

```cmd
.\run.bat .\Templates\Article
```

and the output will be placed in .\Templates\pdf_output

**Note:** if you run _.\run.bat .\Templates\Article\AnotherFolder_, the output will be in .\Templates\Article\pdf_output

This repository can be the root folder of your Latex projects and you can create a private repository inside this one to use only one .sty and one .bat file for all your projects.

## Syntax tips

Latex doesn't like hyphens so name your images with underscores instead of hyphens and use {-} to display a hyphen inside your document. This will prevent the warning to be displayed.  
In the same way, use {} at the end of a command with no parameter to have no warning.

## Debug tips

If an error keeps blocking compilation but the error has actually been corrected, delete the build folder and recompute again. It does't do it by default because otherwise, it would recreate everything each time and it would take more time.
