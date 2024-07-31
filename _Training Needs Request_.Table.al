table 50317 "Training Needs Request"
{
    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    HRSetup.Get;
                    HRSetup.TestField("Training Needs Request Nos.");
                    NoSeriesManagement.TestManual(HRSetup."Training Needs Request Nos.");
                end;
            end;
        }
        field(2; "Need Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Calendar,Appraisal,CPD, Adhoc,Disciplinary';
            OptionMembers = Calendar, Appraisal, CPD, Adhoc, Disciplinary;
        }
        field(3; Provider; Code[20])
        {
            DataClassification = ToBeClassified;
        // TableRelation = Vendor."No.";
        // trigger OnValidate()
        // begin
        //     if Vendor.Get(Provider) then
        //         "Provider Name" := Vendor.Name;
        // end;
        }
        field(4; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GenLedSetup.Get;
                GenLedSetup.TestField("Current Budget Start Date");
                GenLedSetup.TestField("Current Budget End Date");
                if "Start Date" <> 0D then begin
                    if "Start Date" < GenLedSetup."Current Budget Start Date" then Error(Text001, FieldCaption("Start Date"), Format("Start Date"), GenLedSetup.FieldCaption("Current Budget Start Date"), Format(GenLedSetup."Current Budget Start Date"));
                    if "Start Date" > GenLedSetup."Current Budget End Date" then Error(Text002, FieldCaption("Start Date"), Format("Start Date"), GenLedSetup.FieldCaption("Current Budget End Date"), Format(GenLedSetup."Current Budget End Date"));
                    if "End Date" <> 0D then begin
                        if "Start Date" > "End Date" then Error(Text002, FieldCaption("Start Date"), Format("Start Date"), FieldCaption("End Date"), Format("End Date"));
                        if "End Date" < "Start Date" then Error(Text001, FieldCaption("End Date"), Format("End Date"), FieldCaption("Start Date"), Format("Start Date"));
                        Duration:=("End Date" - "Start Date") + 1 end;
                end;
            end;
        }
        field(5; "End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate("Start Date");
            end;
        }
        field(6; "Duration Units"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Hours, Days, Weeks, Months, Years;
        }
        field(7; Duration; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Employee No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get("Employee No")then begin
                    "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    Designation:=Employee."Job Title";
                end;
            end;
        }
        field(9; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Designation; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Training Name"; Code[500])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Training area"; Code[70])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Training Area";
        }
        field(13; Venue; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Source Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Registration fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Need created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Training Objectives"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New, Created, Rejected;
            OptionCaption = 'New, Created, Rejected';
        }
        field(20; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; No, "Source Document No", "Need Source", "Employee No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if No = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Training Needs Request Nos.");
            NoSeriesManagement.InitSeries(HRSetup."Training Needs Request Nos.", xRec."No. Series", 0D, No, "No. Series");
        end;
    end;
    var Employee: Record Employee;
    GenLedSetup: Record "General Ledger Setup";
    Text001: Label 'The %1 %2 cannot be earlier than the %3 %4.';
    Text002: Label 'The %1 %2 cannot be after the %3 %4.';
    NoSeriesManagement: Codeunit NoSeriesManagement;
    HRSetup: Record "Human Resources Setup";
}
