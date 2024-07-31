table 50443 "Lab Maintenance Registration"
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
        //         "Current Odometer Reading" := FA."Current Odometer Reading";
        //     end;
        // end;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Service Date"; Date)
        {
            Caption = 'Service Date';
        }
        field(4; "Maintenance Vendor No."; Code[20])
        {
            Caption = 'Maintenance Vendor No.';
            TableRelation = Vendor;
        }
        field(5; Comment; Text[50])
        {
            Caption = 'Comment';
        }
        field(6; "Service Agent Name"; Text[30])
        {
            Caption = 'Service Agent Name';
        }
        field(7; "Service Agent Phone No."; Text[30])
        {
            Caption = 'Service Agent Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(8; "Service Agent Mobile Phone"; Text[30])
        {
            Caption = 'Service Agent Mobile Phone';
            ExtendedDatatype = PhoneNo;
        }
        field(9; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if(Fleet=const(true))"Fixed Asset" where("Fixed Asset Type"=const(Fleet))
            else if(Fleet=const(false))"Fixed Asset" where("Fixed Asset Type"=filter(<>Fleet));
        }
        field(10; "Item Description"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Service Provider"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if VendorRec.Get("Service Provider")then "Service Provider Name":=VendorRec.Name;
            end;
        }
        field(12; "Service Provider Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Service Intervals"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                ServiceIntervals.RESET;
                ServiceIntervals.SETRANGE(ServiceIntervals."Service Interval Code","Service Intervals");
                IF ServiceIntervals.FIND('-') THEN BEGIN
                  "Service Period":=ServiceIntervals."Service Period";
                  "Service Mileage":=ServiceIntervals."Service Mileage";
                END;
                */
            end;
        }
        field(14; "Date of Service"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Next Service"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Service/Repair Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Service LSO/LPO No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header";
        }
        field(20; "Item Class Code"; Code[10])
        {
            Caption = 'FA Class Code';
            DataClassification = ToBeClassified;
            TableRelation = "FA Class";
        }
        field(21; "Current Odometer Reading"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Service Interval Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Mileage,Periodical';
            OptionMembers = " ", Mileage, Periodical;
        }
        field(23; "Service Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Service Mileage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Driver Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Driver's Signature"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(28; "Transport Manager Remarks"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Maintenance No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(30; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(31; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New, "Pending Approval", Approved;
        }
        field(32; "No. Series"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(33; Employee; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                EmployeeRec.Reset;
                EmployeeRec.SetRange("No.", Employee);
                if EmployeeRec.Find('-')then begin
                    "Driver Name":=EmployeeRec."First Name" + ' ' + EmployeeRec."Middle Name" + ' ' + EmployeeRec."Last Name";
                    Signature:=EmployeeRec.Signature;
                end;
            end;
        }
        field(34; "Next Service Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(35; Signature; MediaSet)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Service Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", "Routine Service", Repair;
        }
        field(37; Fleet; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(38; Archive; Boolean)
        {
            DataClassification = ToBeClassified;
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
            LabSetup.TestField("Maintenance Request Nos");
            NoSeriesMgt.InitSeries(LabSetup."Maintenance Request Nos", xRec."No. Series", 0D, "Maintenance No", "No. Series");
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
