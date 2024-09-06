tableextension 50104 MaintenanceRegExt extends "Maintenance Registration"
{
    fields
    {
        modify("FA No.")
        {
            trigger OnAfterValidate()
            begin
                FixedAsset.Reset();
                FixedAsset.SetRange("No.", "FA No.");
                if FixedAsset.FindFirst() then begin
                    "Item Description" := FixedAsset.Description;
                    "Item Class Code" := FixedAsset."FA Class Code";
                end;
                if "Maintenance No" = '' then begin
                    HRSetup.Get;
                    HRSetup.TestField("Vehicle Maintenance Nos");
                    NoSeriesMgt.InitSeries(HRSetup."Vehicle Maintenance Nos", xRec."No. Series", 0D, "Maintenance No", "No. Series");
                end;
            end;
        }
        field(50000; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if (Fleet = const(true)) "Fixed Asset" where("Fixed Asset Type" = const(Fleet))
            else if (Fleet = const(false)) "Fixed Asset" where("Fixed Asset Type" = filter(<> Fleet));
            // trigger OnValidate()
            // begin
            //     FixedAsset.Reset();
            //     FixedAsset.SetRange("No.", "Item No.");
            //     if FixedAsset.FindFirst() then begin
            //         "Item Description" := FixedAsset.Description;
            //         "Item Class Code" := FixedAsset."FA Class Code";
            //     end;
            //     if "Maintenance No" = '' then begin
            //         HRSetup.Get;
            //         HRSetup.TestField("Vehicle Maintenance Nos");
            //         NoSeriesMgt.InitSeries(HRSetup."Vehicle Maintenance Nos", xRec."No. Series", 0D, "Maintenance No", "No. Series");
            //     end;
            // end;
        }
        field(50001; "Item Description"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Service Provider"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if VendorRec.Get("Service Provider") then "Service Provider Name" := VendorRec.Name;
            end;
        }
        field(50003; "Service Provider Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Service Intervals"; Code[30])
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
        field(50005; "Date of Service"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Next Service"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Service/Repair Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Service LSO/LPO No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header";
        }
        field(50011; "Item Class Code"; Code[10])
        {
            Caption = 'FA Class Code';
            DataClassification = ToBeClassified;
            TableRelation = "FA Class";
        }
        field(50012; "Current Odometer Reading"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Service Interval Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Mileage,Periodical';
            OptionMembers = " ",Mileage,Periodical;
        }
        field(50014; "Service Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Service Mileage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Driver Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Driver's Signature"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50019; "Transport Manager Remarks"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Maintenance No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(50023; "No. Series"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; Employee; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                EmployeeRec.Reset;
                EmployeeRec.SetRange("No.", Employee);
                if EmployeeRec.Find('-') then begin
                    "Driver Name" := EmployeeRec."First Name" + ' ' + EmployeeRec."Middle Name" + ' ' + EmployeeRec."Last Name";
                    Signature := EmployeeRec.Signature;
                end;
            end;
        }
        field(50025; "Next Service Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; Signature; MediaSet)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Service Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Routine Service",Repair;
        }
        field(50028; Fleet; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; Archive; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; Lab; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    var
        FA: Record "Fixed Asset";
        VendorRec: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmployeeRec: Record Employee;
}
