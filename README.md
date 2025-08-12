# DICOM to BIDS Conversion Instructions

```text
08-02-2022
Bruno Robalo, PMC

This script organizes MRI DICOM data received from the Bdac Committee into
NIfTI and JSON files in a BIDS-like structure.

Initially, the data should be stored on the Isilon storage system.
```

---

## Step 1 — Before Downloading the Data
1. Connect to Isilon (ask Research IT):  
   ```
 
   ```

---

## Step 2 — Downloading the Data
1. Request access from the **Bdac Committee**.  
2. Provide:
   - Biobank approval  
   - PMCIDs / PMCRADs  
3. Once the data is available on RiA, download it.  
4. Download directly to Isilon in a new project folder:  
   ```
   <Isilon mount>/MRIdata/<PMC biobank approval number, e.g. PMCLAB2019.084>
   ```
5. After downloading, **remove the data from RiA**.  
6. Together with the MRI data, you should receive a file:  
   ```
   koppellijst.csv
   ```
   This file couples the PMCIDs with the PMCRADs and contains MRI session details — **save this file**.

---

## Step 3 — Unzipping and Copying
1. Unzip all folders (can be done recursively).  
2. After unzipping → rename all subject folders to their corresponding PMCIDs and PMCRADs using the `koppellijst.csv` (**write a script for this**). Combine with the next step.  
3. **Run a script (MATLAB or Excel macro)** to create the `sub-` and `ses-` naming for the BIDS structure in the complete koppellijst file:  
   - Sort subjects alphabetically  
   - Sort sessions (within each subject) by examination date  
4. Rename folder structure to:  
   ```
   sub-00xx/ses-mri00x
   ```
   **Move all DICOM series one folder up**.  
5. Convert DICOM to NIfTI with `dcm2niix` → results go into a **temporary `raw_nii`** folder.  
6. Convert to BIDS — name the folder something meaningful (this becomes the new raw data).  
7. From the koppellijst, select only the rows you need (e.g., by examination date, field strength, or scanned body part).  
8. Copy only the required data (`sub-00xx/ses-mri00x`) to your project folder:  
   ```
   <Isilon mount>/MRIProject/<Project name>
   ```
9. From this point, data can be copied to computing servers for analysis.
