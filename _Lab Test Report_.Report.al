report 50348 "Lab Test Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './LabTestReport.rdl';
    Caption = 'Lab Test Results';
    ApplicationArea = All;

    dataset
    {
        dataitem(SampleTestHeader; "Sample Test Header")
        {
            column(TestNo; "Test No.")
            {
            }
            column(Test; Test)
            {
            }
            column(TestForm; TestForm)
            {
            }
            column(Labsection; "Lab section")
            {
            }
            dataitem(SampleTest; "Sample Test")
            {
                DataItemLink = "Test No." = field("Test No.");

                column(SNo; "S/No")
                {
                }
                column(SampleID; "Sample ID")
                {
                }
                column(SampleName; "Sample Name")
                {
                }
                column(TestToConduct; TestToConduct2)
                {
                }
                column(ColorIndication; "Color Indication")
                {
                }
                column(Specifications; Specifications)
                {
                }
                column(Interpretation_Pasteurized_; "Interpretation(Pasteurized)")
                {
                }
                column(Resultspotassiumiodide; "Results potassium iodide")
                {
                }
                column(ResultsRapidtestmgL; "Results Rapid test (mg/L)")
                {
                }
                column(InterpretationPreserved; "Interpretation(Preserved)")
                {
                }
                column(ButterFatcontent; "Butter Fat content (%)")
                {
                }
                column(RemarksPassFail; "Remarks(PassFail)")
                {
                }
                column(Specification; "Specification (%)")
                {
                }
                column(AlcoholTestResults; "Alcohol Test Results")
                {
                }
                column(AlcoholTestSpecifications; "Alcohol Test Specifications")
                {
                }
                column(Resazurintestresults; "Resazurin test results")
                {
                }
                column(ResazurinTestSpecifications; "Resazurin Test Specifications")
                {
                }
                column(Sulfonamide; Sulfonamide)
                {
                }
                column(BetaLactam; "Beta-Lactam")
                {
                }
                column(Brixcontentgml; "Brix content (g/ml)")
                {
                }
                column(Tetracycline; Tetracycline)
                {
                }
                column(Flowtimeinseconds; "Flow time in seconds")
                {
                }
                column(Resultsingml; "Results in g/ml")
                {
                }
                column(Specificationsgml; "Specifications g/ml")
                {
                }
                column(OdourandTaints; "Odour and Taints ")
                {
                }
                column(Colour; Colour)
                {
                }
                column(Titerml; "Titer (ml)")
                {
                }
                column(Constant0282; "Constant (0.282)")
                {
                }
                column(Results; Results)
                {
                }
                column(W1; W1)
                {
                }
                column(W2; W2)
                {
                }
                column(W3; W3)
                {
                }
                column(W4; W4)
                {
                }
                column(Moisturecontentww; "Moisture content (%w/w)")
                {
                }
                column(MoistureContentW3W4W2; "Moisture Content((W3-W4)/W2")
                {
                }
                column(Specificationww; "Specification (%w/w)")
                {
                }
                column(Volumeinoculatedinmlv; "Volume inoculated in ml(v)")
                {
                }
                column(Numberofplates1stdilution; "Number of plates 1st dilution")
                {
                }
                column(Numberofplates2nddilution; "Number of plates 2nd dilution")
                {
                }
                column(Counts1stdilution; "Counts 1st dilution")
                {
                }
                column(Counts2ddilution; "Counts 2d dilution")
                {
                }
                column(Sumofcountsxy; "Sum of counts(x  + y)")
                {
                }
                column(Dilutionfactorusedinn1d; "Dilution factor used in n1(d)")
                {
                }
                column(Constant01; "Constant (0.1)")
                {
                }
                column(ColonyCvn101n2d; "Colony (∑^ ▒〖C 〗)/v(n1+0.1n2)d")
                {
                }
                column(SpecificationCFUml; "Specification (CFU/ml)")
                {
                }
                column(RVScolorchange; "RVS color change")
                {
                }
                column(XLDplates; "XLD plates")
                {
                }
                column(Butt; Butt)
                {
                }
                column(Slant; Slant)
                {
                }
                column(Gasproduction; "Gas production")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
