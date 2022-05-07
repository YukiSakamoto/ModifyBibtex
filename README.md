# ModifyBibtex

This script reads .bib file and convert journal names into its abbreviations.

## Example 

To run this script, specify the .bib file.
The script prints the result for the standard output (stdout).

```
> ruby convert ref_dft.bib > ref_abbr.bib
```

* before

```
@article{DFT_HK_1964,
  title={Inhomogeneous electron gas},
  author={Hohenberg, Pierre and Kohn, Walter},
  journal={Physical Review},
  volume={136},
  number={3B},
  pages = {B864--B871},
  year={1964},
  publisher={APS}
}
```

* after

```
@article{DFT_HK_1964,
  title={Inhomogeneous electron gas},
  author={Hohenberg, Pierre and Kohn, Walter},
  journal={Phys. Rev.},
  volume={136},
  number={3B},
  pages = {B864--B871},
  year={1964},
  publisher={APS}
}
```
