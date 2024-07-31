table 50577 "Sample Test"
{
    Caption = 'Sample Test';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Source Document No"; Code[20])
        {
            Caption = 'Source Document No';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Sample ID"; Code[20])
        {
            Caption = 'Sample Code';
            DataClassification = ToBeClassified;
        // TableRelation = "Sample Target Test LineNew"."Sample ID" where(Code = field(TestToConduct));
        // trigger OnValidate()
        // var
        //     SampleRec: Record "Sample Reception";
        // begin
        //     SampleRec.Reset();
        //     SampleRec.SetRange(SampleID, "Sample ID");
        //     if SampleRec.FindFirst() then
        //         "Sample Name" := SampleRec."Sample Name";
        // end;
        }
        field(4; "Sample Name"; Text[50])
        {
            Caption = 'Sample Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Color Indication"; Text[50])
        {
            Caption = 'Color Indication';
            DataClassification = ToBeClassified;
        }
        field(6; "Interpretation(Pasteurized)"; Option)
        {
            Caption = 'Interpretation (Pasteurized/not Pasteurized)';
            DataClassification = ToBeClassified;
            OptionMembers = " ", Pasteurized, "not Pasteurized";
        }
        field(7; "Done By"; Code[100])
        {
            Caption = 'Done By';
            TableRelation = Employee;
            DataClassification = ToBeClassified;
        }
        field(8; "Checked By"; Code[100])
        {
            Caption = 'Checked By';
            TableRelation = Employee;
            DataClassification = ToBeClassified;
        }
        field(9; "Results Rapid test (mg/L)"; Code[50])
        {
            Caption = 'Results for the Rapid test (mg/L)';
            DataClassification = ToBeClassified;
        }
        field(10; "Results potassium iodide"; Option)
        {
            Caption = 'Results for potassium iodide-starch test method (Absent/present)';
            OptionMembers = " ", Absent, Present;
            DataClassification = ToBeClassified;
        }
        field(11; "Interpretation(Preserved)"; Option)
        {
            Caption = 'Interpretation (Preserved/not Preserved)';
            DataClassification = ToBeClassified;
            OptionMembers = " ", Preserved, "not Preserved";
        }
        field(12; "Butter Fat content (%)"; Decimal)
        {
            Caption = 'Butter Fat content (%)';
            DataClassification = ToBeClassified;
        }
        field(13; "Specification (%)"; Decimal)
        {
            Caption = 'Specification (%)';
            DataClassification = ToBeClassified;
        }
        field(14; "Remarks(PassFail)"; Option)
        {
            Caption = 'Remarks (Complies/Does not comply)';
            DataClassification = ToBeClassified;
            OptionMembers = " ", Comply, "Doen't comply";
            OptionCaption = ' ,Complies,Does not comply';
        }
        field(15; "Alcohol Test Results"; Option)
        {
            Caption = 'Alcohol test results (positive/negative)';
            DataClassification = ToBeClassified;
            OptionMembers = " ", Positive, Negative;
        }
        field(16; "Alcohol Test Specifications"; Code[2048])
        {
            Caption = 'Alcohol test Specifications';
            DataClassification = ToBeClassified;
        }
        field(17; "Resazurin test results"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Grade1, Grade2, Grade3, Grade4, Grade5, Grade6;
        }
        field(18; "Resazurin Test Specifications"; Code[2048])
        {
            Caption = 'Resazurin test specifications';
            DataClassification = ToBeClassified;
        }
        field(19; Remarks; Code[2000])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(20; "Sulfonamide"; Option)
        {
            Caption = 'Sulfonamide (detected/not detected)';
            DataClassification = ToBeClassified;
            OptionMembers = " ", Detected, "not Detected";
        }
        field(21; "Beta-Lactam"; Option)
        {
            Caption = 'Beta-Lactam (detected/not detected)';
            DataClassification = ToBeClassified;
            OptionMembers = " ", Detected, "not Detected";
        }
        field(22; "Tetracycline"; Option)
        {
            Caption = 'Tetracycline (detected/not detected)';
            DataClassification = ToBeClassified;
            OptionMembers = " ", Detected, "not Detected";
        }
        field(23; "Flow time in seconds"; Decimal)
        {
            Caption = 'Flow time in seconds';
            DataClassification = ToBeClassified;
        }
        field(24; "Results in g/ml"; Decimal)
        {
            DecimalPlaces = 1: 3;
            Caption = 'Results in g/ml';
            DataClassification = ToBeClassified;
        }
        field(25; "Specifications g/ml"; Decimal)
        {
            DecimalPlaces = 1: 3;
            Caption = 'Specifications g/ml';
            DataClassification = ToBeClassified;
        }
        field(26; "Brix content (g/ml)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; Colour; Text[50])
        {
            Caption = 'Colour';
            DataClassification = ToBeClassified;
        }
        field(28; "Odour and Taints "; Text[2000])
        {
            Caption = 'Odour and Taints ';
            DataClassification = ToBeClassified;
        }
        field(29; "Titer (ml)"; Decimal)
        {
            DecimalPlaces = 1: 4;
            Caption = 'Titer (ml)';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
            end;
        }
        field(30; "Constant (0.282)"; Decimal)
        {
            Caption = 'Constant (0.282)';
            DataClassification = ToBeClassified;
        }
        field(31; Results; Code[2000])
        {
            Caption = 'Results';
            DataClassification = ToBeClassified;
        }
        field(32; W1; Decimal)
        {
            Caption = 'W1';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                W3:=W1 + W2;
            end;
        }
        field(33; W2; Decimal)
        {
            Caption = 'W2';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                W3:=W1 + W2;
            end;
        }
        field(34; W3; Decimal)
        {
            Caption = 'W3';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
            begin
                "Moisture Content((W3-W4)/W2":=((W3 - W4) / W2) * 100;
            end;
        }
        field(35; W4; Decimal)
        {
            Caption = 'W4';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Moisture Content((W3-W4)/W2":=((W3 - W4) / W2) * 100;
            end;
        }
        field(36; "Moisture content (%w/w)"; Decimal)
        {
            Caption = 'Moisture content (%w/w)';
            DataClassification = ToBeClassified;
        }
        field(37; "Specification (%w/w)"; Decimal)
        {
            Caption = 'Specification (%w/w)';
            DataClassification = ToBeClassified;
        }
        field(38; "Dilutions done"; Integer)
        {
            Caption = 'Dilutions done';
            DataClassification = ToBeClassified;
        }
        field(39; "Counts per Dilution"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Calculation"; Decimal)
        {
            Caption = 'Calculation (∑^ ▒〖C 〗)/v(n1+0.1n2)d)';
            DataClassification = ToBeClassified;
        }
        field(41; "Results cfu/ml"; Decimal)
        {
            Caption = 'Results cfu/ml';
            DataClassification = ToBeClassified;
        }
        field(42; "RVS color change"; Option)
        {
            Caption = 'RVS color change (no change/faint blue)';
            DataClassification = ToBeClassified;
            OptionMembers = " ", "No Change", "Faint Blue";
        }
        field(43; "XLD plates"; Option)
        {
            Caption = 'XLD plates (colonies/no colonies)';
            DataClassification = ToBeClassified;
            OptionMembers = " ", Colonies, "No colonies";
        }
        field(44; Butt; Code[200])
        {
            Caption = 'Butt';
            DataClassification = ToBeClassified;
        }
        field(45; Slant; Code[200])
        {
            Caption = 'Slant';
            DataClassification = ToBeClassified;
        }
        field(46; "Gas production"; Code[200])
        {
            Caption = 'Gas production';
            DataClassification = ToBeClassified;
        }
        field(47; "Remarks(Present"; Option)
        {
            Caption = 'Remarks Present/ absent';
            DataClassification = ToBeClassified;
            OptionMembers = " ", Present, Absent;
        }
        field(48; "Counts per Dilution 120h(Y)"; Integer)
        {
            Caption = 'Counts per Dilution in 120 hours(Y)';
            DataClassification = ToBeClassified;
        }
        field(49; "Counts per Dilution 120h(M)"; Integer)
        {
            Caption = 'Counts per Dilution in 120 hours(M)';
            DataClassification = ToBeClassified;
        }
        field(50; "Calculation(Y)"; Decimal)
        {
            Caption = 'Calculation (∑^ ▒〖C 〗)/v(n1+0.1n2)d(Y)';
            DataClassification = ToBeClassified;
        }
        field(51; "Calculation(M)"; Decimal)
        {
            Caption = 'Calculation (∑^ ▒〖C 〗)/v(n1+0.1n2)d(M)';
            DataClassification = ToBeClassified;
        }
        field(52; "Results cfu/ml(Y)"; Decimal)
        {
            Caption = 'Results cfu/ml(Y)';
            DataClassification = ToBeClassified;
        }
        field(53; "Results cfu/ml(M)"; Decimal)
        {
            Caption = 'Results cfu/ml(M)';
            DataClassification = ToBeClassified;
        }
        field(54; "Specifications(Y)"; Code[2048])
        {
            Caption = 'Specifications(Y)';
            DataClassification = ToBeClassified;
        }
        field(55; "Specifications(M)"; Code[2048])
        {
            Caption = 'Specifications(M)';
            DataClassification = ToBeClassified;
        }
        field(56; "Test No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(57; Submitted; Boolean)
        {
            Caption = 'Submitted';
            FieldClass = FlowField;
            CalcFormula = Lookup("Sample Test Header".Submitted WHERE("Test No."=FIELD("Test No.")));
        }
        field(58; "S/No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(59; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Specifications"; Code[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(62; Test;Enum LabTestForms)
        {
            DataClassification = ToBeClassified;
        }
        field(63; TestToConduct; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(64; TestToConduct2;enum LabTestForms)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Volume inoculated in ml(v)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Number of plates 1st dilution"; Decimal)
        {
            Caption = 'Number of plates inoculated in First dilution(n1)';
            DataClassification = ToBeClassified;
        }
        field(67; "Number of plates 2nd dilution"; Decimal)
        {
            Caption = 'Number of plates inoculated in Second dilution(n2)';
            DataClassification = ToBeClassified;
        }
        field(68; "Counts 1st dilution"; Decimal)
        {
            Caption = 'Counts in First Dilution(x)';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Constant (0.1)":=0.1;
                "Sum of counts(x  + y)":="Counts 1st dilution" + "Counts 2d dilution";
            end;
        }
        field(69; "Counts 2d dilution"; Decimal)
        {
            Caption = 'Counts in Second Dilution(y)';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Constant (0.1)":=0.1;
                "Sum of counts(x  + y)":="Counts 1st dilution" + "Counts 2d dilution";
                if "Dilution factor code" <> '' then Validate("Sum of counts(x  + y)");
            end;
        }
        field(70; "Sum of counts(x  + y)"; Decimal)
        {
            Caption = 'Sum of counts in First and Second Dilution C = (x+y)';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Colony (∑^ ▒〖C 〗)/v(n1+0.1n2)d":="Sum of counts(x  + y)" / ("Volume inoculated in ml(v)" * ("Number of plates 1st dilution" + (0.1 * "Number of plates 2nd dilution")) * Power(Number, Exponential));
            end;
        }
        field(71; "Dilution factor used in n1(d)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Colony (∑^ ▒〖C 〗)/v(n1+0.1n2)d":="Sum of counts(x  + y)" / ("Volume inoculated in ml(v)" * ("Number of plates 1st dilution" + (0.1 * "Number of plates 2nd dilution")) * Power(Number, Exponential));
            end;
        }
        field(72; "Constant (0.1)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73; "Colony (∑^ ▒〖C 〗)/v(n1+0.1n2)d"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(74; "Specification (CFU/ml)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Moisture Content((W3-W4)/W2"; Decimal)
        {
            Caption = 'Moisture Content(%w/w)(W3-W4)/W2x100';
            DataClassification = ToBeClassified;
        }
        field(76; "Dilution factor code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dilution Factor Setup";

            trigger OnValidate()
            var
                Dil: Record "Dilution Factor Setup";
            begin
                Dil.Reset();
                Dil.SetRange(Code, "Dilution factor code");
                if Dil.FindFirst()then begin
                    Number:=Dil.Number;
                    Exponential:=dil.Exponential;
                    "Dilution factor used in n1(d)":=Power(Number, Exponential);
                    Validate("Dilution factor used in n1(d)");
                end;
            end;
        }
        field(77; Number; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(78; Exponential; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Alcohol Test Specifications2"; Decimal)
        {
            Caption = 'Alcohol test Specifications';
            DataClassification = ToBeClassified;
        }
        field(80; "Resazurin Test Specifications2"; Decimal)
        {
            Caption = 'Resazurin test specifications';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Resazurin Test Specifications2" > "Alcohol Test Specifications2" then "Remarks(PassFail)":="Remarks(PassFail)"::"Doen't comply"
                else
                    "Remarks(PassFail)":="Remarks(PassFail)"::Comply;
            end;
        }
        field(81; "Specification Code"; Decimal)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dilution Factor Setup".Code where(Type=filter(Specifications));

            trigger OnValidate()
            var
                SpecSetup: Record "Dilution Factor Setup";
            begin
                if SpecSetup.Get("Specification Code")then begin
                    SpecSetup.TestField(Exponential);
                    if("Butter Fat content (%)" > SpecSetup.Number) and ("Butter Fat content (%)" < SpecSetup.Exponential)then "Remarks(PassFail)":="Remarks(PassFail)"::Comply
                    else
                        "Remarks(PassFail)":="Remarks(PassFail)"::"Doen't comply";
                end;
            end;
        }
        field(82; "Cannot be done"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(83; Comment; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(84; "Analysis No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Test No.", "Done By", "Checked By", Test, "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        Date:=Today;
    end;
    trigger OnModify()
    begin
        IF UserSetup.GET(USERID)THEN BEGIN
            UserSetup.TESTFIELD("Employee No.");
            IF Employee.GET(UserSetup."Employee No.")THEN BEGIN
                // "Testing officer No." := Employee."No.";
                SampleTestHeader.Reset();
                SampleTestHeader.SetRange("Test No.", "Test No.");
                if SampleTestHeader.FindFirst()then begin
                    SampleTestHeader."Done By No.":=Employee."No.";
                    SampleTestHeader."Done By":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    SampleTestHeader.Modify();
                end;
            END;
        END;
    end;
    var Employee: Record Employee;
    UserSetup: Record "User Setup";
    Labsetup: Record "Lab Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    SampleTestHeader: Record "Sample Test Header";
}
