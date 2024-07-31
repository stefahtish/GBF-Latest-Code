table 50335 "Lab Calibration Registration"
{
    Caption = 'Lab Maintenance Registration';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "FA No."; Code[20])
        {
        // Caption = 'FA No.';
        // NotBlank = true;
        // TableRelation = "Fixed Asset" where(lab = const(true));
        // trigger OnValidate()
        // var
        //     FA: Record "Fixed Asset";
        // begin
        //     FA.SetRange("No.", "FA No.");
        //     if FA.FindFirst() then begin
        //         Description := FA.Description;
        //     end;
        // end;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "In-house", External;
        // OptionCaption = 'Item,Fixed Asset';
        }
        field(4; Comment; Text[50])
        {
            Caption = 'Comment';
        }
        field(5; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
            end;
        }
        field(6; Description; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Service Provider Name"; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(8; "Date of Service"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Calibration Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Employee No"; Code[20])
        {
            caption = 'No';
            DataClassification = ToBeClassified;
            TableRelation = if(Type=filter("In-house"))Employee
            else if(Type=filter(External))Vendor;

            trigger OnValidate()
            var
                Emp: record Employee;
                vend: Record Vendor;
            begin
                if Emp.get("Employee No")then "Service Provider Name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                if vend.get("Employee No")then "Service Provider Name":=vend.Name;
            end;
        }
        field(12; "Transport Manager Remarks"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Maintenance No"; Code[30])
        {
            caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(14; "Next Calibration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ", Pass, Fail;
        }
        field(16; "No. Series"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Calibration Method"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Calibration Methods";
        }
        field(18; Frequency; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Action; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Responsible Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Emp: record Employee;
            begin
                if Emp.get("Responsible Employee No")then "Responsible Employee name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(21; "Responsible Employee name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Calibration Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open, "On-going", Completed;
        }
    }
    keys
    {
        key(Key1; "FA No.", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        FA.LockTable();
        FA.Get("FA No.");
        if "Maintenance No" = '' then begin
            LabSetup.Get;
            LabSetup.TestField("Calibration Request Nos");
            NoSeriesMgt.InitSeries(LabSetup."Calibration Request Nos", xRec."No. Series", 0D, "Maintenance No", "No. Series");
        end;
        GetNextLineNo();
    end;
    var FA: Record "Fixed Asset";
    VendorRec: Record Vendor;
    FixedAsset: Record "Fixed Asset";
    LabSetup: Record "Lab Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    EmployeeRec: Record Employee;
    local procedure GetNextLineNo(): Integer var
        LabReg: Record "Lab Maintenance Registration";
    begin
        LabReg.RESET;
        IF LabReg.FINDLAST THEN EXIT(LabReg."Line No." + 1)
        ELSE
            EXIT(1);
    end;
}
