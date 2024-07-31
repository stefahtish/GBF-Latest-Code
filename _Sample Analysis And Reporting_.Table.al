table 50568 "Sample Analysis And Reporting"
{
    Caption = 'Sample analysis and reporting';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Analysis No."; Code[20])
        {
            Caption = 'Analysis No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Analysis No." <> '' THEN NoSeriesMgt.TestManual(Labsetup."Sample Analysis Nos");
            end;
        }
        field(2; "Sample ID"; Code[20])
        {
            Caption = 'Sample Code';
            DataClassification = ToBeClassified;
            TableRelation = "Sample Reception Header".SampleID;
        }
        field(3; "Sample temperature"; Decimal)
        {
            Caption = 'Sample temperature';
            DataClassification = ToBeClassified;
        }
        field(4; "Lab section received"; Text[100])
        {
            Caption = 'Lab section received';
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Setup Type" where(Type=const("Lab section to test"));

            trigger OnValidate()
            var
                Labsetup: Record "Laboratory Setup Type";
            begin
                Labsetup.Reset();
                Labsetup.SetRange(Name, "Lab section received");
                if Labsetup.FindFirst()then begin
                    "Testing officer No.":=Labsetup."Employee No.";
                    "Testing officer":=Labsetup."Employee Name";
                end;
            end;
        }
        field(5; "Testing date"; Date)
        {
            Caption = 'Testing date';
            DataClassification = ToBeClassified;
        }
        field(6; "Testing officer"; Text[100])
        {
            Caption = 'Testing officer';
            DataClassification = ToBeClassified;
        }
        field(7; Results; Text[500])
        {
            Caption = 'Results';
            DataClassification = ToBeClassified;
        }
        field(8; "Results date"; Date)
        {
            Caption = 'Results date';
            DataClassification = ToBeClassified;
        }
        field(9; "Result verification date"; Date)
        {
            Caption = 'Result verification date';
            DataClassification = ToBeClassified;
        }
        field(10; "Result authorization date"; Date)
        {
            Caption = 'Result authorization date';
            DataClassification = ToBeClassified;
        }
        field(11; "Authorization officer"; Text[100])
        {
            Caption = 'Authorization officer';
            DataClassification = ToBeClassified;
        }
        field(12; Remarks; Text[100])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(13; "Date results submitted"; Date)
        {
            Caption = 'Date results submitted';
            DataClassification = ToBeClassified;
        }
        field(14; "Date of sample disposal"; Date)
        {
            Caption = 'Date of sample disposal';
            DataClassification = ToBeClassified;
        }
        field(15; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Testing officer No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Emp: Record Employee;
                SampleTestHeader: Record "Sample Test Header";
            begin
                Emp.Reset();
                Emp.SetRange("No.", "Testing officer No.");
                if Emp.FindFirst()then "Testing officer":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                SampleTestHeader.Reset();
                SampleTestHeader.SetRange("Sample Reception No", "Sample Reception No");
                if SampleTestHeader.find('-')then repeat SampleTestHeader."Done By No.":="Testing officer No.";
                        SampleTestHeader.Validate("Done By No.");
                        SampleTestHeader.Modify();
                    until SampleTestHeader.Next = 0;
            end;
        }
        field(17; "Submit results"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Sample Name"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "COA No."; Code[20])
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "COA No." <> '' THEN NoSeriesMgt.TestManual(LabSetup."COA Nos");
            end;
        }
        field(20; Status; Option)
        {
            OptionMembers = Open, "Pending Approval", Released;
            DataClassification = ToBeClassified;
        }
        field(21; "Correct Entries"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ", Yes, No;
        }
        field(22; "Correct Label"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ", Yes, No;
        }
        field(23; "Resource Availability"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ", Yes, No;
        }
        field(24; "Disposed By"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(25; "Disposed By Name"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Verified By"; Code[20])
        {
            Caption = 'Authorized By';
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Emp: Record Employee;
            begin
                Emp.Reset();
                Emp.SetRange("No.", "Verified By");
                if Emp.FindFirst()then "Authorization officer":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(27; "Verified By Name"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Authorized By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Manufacture Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(32; Client; Text[100])
        {
            Caption = 'Client';
            DataClassification = ToBeClassified;
        //TableRelation = Customer;
        }
        field(33; "KDB License number"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Client Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Sample Type"; Option)
        {
            OptionMembers = " ", "From Schedule", Client;
            OptionCaption = ' ,From Schedule,Client';
            DataClassification = ToBeClassified;
        }
        field(36; "Schedule No."; Code[10])
        {
            TableRelation = "Lab Annual Testing Schedule";
            DataClassification = ToBeClassified;
        }
        field(38; "Sample Disposal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(39; Disposed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(40; Cluster; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Cluster Regions";
        }
        field(41; "Cluster Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Cluster;
            OptionCaption = ' ,Cluster';
        }
        field(42; Archived; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Sample Reception No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Approval datetime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Sent To lab"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Can be done"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sample Test" where("Analysis No."=field("Analysis No."), "Cannot be done"=const(false)));
        }
        field(47; "Cannot be done"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sample Test" where("Analysis No."=field("Analysis No."), "Cannot be done"=const(true)));
        }
    }
    keys
    {
        key(PK; "Analysis No.")
        {
            Clustered = true;
        }
        key(Sk; "Sample ID")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Analysis No.", "Sample ID", "Sample Name")
        {
        }
    }
    trigger OnInsert()
    begin
        if not Labsetup.Get()then begin
            Labsetup.Init();
            Labsetup.Insert();
        end;
        Labsetup.TESTFIELD("Sample Analysis Nos");
        Labsetup.TestField("COA Nos");
        NoSeriesMgt.InitSeries(Labsetup."Sample Analysis Nos", xRec."No. Series", TODAY, "Analysis No.", "No. Series");
        NoSeriesMgt.InitSeries(Labsetup."COA Nos", xRec."No. Series", TODAY, "COA No.", "No. Series");
    end;
    var Employee: Record Employee;
    UserSetup: Record "User Setup";
    Labsetup: Record "Lab Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
