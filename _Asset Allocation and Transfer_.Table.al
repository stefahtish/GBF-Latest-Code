table 50172 "Asset Allocation and Transfer"
{
    Caption = 'Asset Allocation and Transfer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger Onvalidate()
            begin
                if Type = Type::"Initial Allocation" then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(HrSetup."Asset Allocation Nos");
                end;
                if Type = Type::Transfer then begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(HrSetup."Asset Transfer Nos");
                end;
            end;
        }
        field(2; Asset; Code[20])
        {
            Caption = 'Asset';
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset";

            trigger OnValidate()
            var
                FixedAsset: Record "Fixed Asset";
                Transfer: Record "Asset Allocation and Transfer";
            begin
                if FixedAsset.Get(Asset)then begin
                    if Type = Type::Transfer then begin
                        FixedAsset.Reset();
                        FixedAsset.SetRange("No.", Asset);
                        if Transfer.FindFirst()then "Current Employee No.":=FixedAsset."Responsible Employee";
                        Validate("Current Employee No.");
                        "Current Branch":=FixedAsset."Global Dimension 1 Code";
                    end;
                    if Type = Type::"Initial Allocation" then begin
                        Transfer.Reset();
                        Transfer.SetRange(Transfer.Asset, Asset);
                        Transfer.SetRange(Allocated, true);
                        if Transfer.FindFirst()then Error('The asset has already been allocated, please do a transfer');
                    end;
                    if FixedAsset."Fixed Asset Type" = FixedAsset."Fixed Asset Type"::Fleet then begin
                        "Asset Description":=FixedAsset.Description;
                        "Car Registration No.":=FixedAsset."Registration No";
                        "Chasis Number":=FixedAsset."Chassis No.";
                        "Engine Number":=FixedAsset."Engine No.";
                        "Current Employee No.":=FixedAsset."Responsible Employee";
                        "Current Employee name":=FixedAsset."Employee Name";
                        "Current Branch":=FixedAsset."Global Dimension 1 Code";
                        "Current Department":=FixedAsset."Global Dimension 2 Code";
                        "Tag Number":=FixedAsset."Tag Number";
                    end;
                    if FixedAsset."Fixed Asset Type" = FixedAsset."Fixed Asset Type"::" " then begin
                        "Asset Description":=FixedAsset.Description;
                        "Car Registration No.":=FixedAsset."Registration No";
                        "Current Employee No.":=FixedAsset."Responsible Employee";
                        "Current Employee name":=FixedAsset."Employee Name";
                        "Current Branch":=FixedAsset."Global Dimension 1 Code";
                        "Current Department":=FixedAsset."Global Dimension 2 Code";
                        "Tag Number":=FixedAsset."Tag Number";
                        "Serial No.":=FixedAsset."Serial No.";
                    end;
                end;
            end;
        }
        field(3; "Asset Description"; Code[200])
        {
            Caption = 'Asset Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Current Employee No."; Code[10])
        {
            Caption = 'Current Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get("Current Employee No.")then "Current Employee name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(5; "Current Employee name"; Text[100])
        {
            Caption = 'Current Employee name';
            DataClassification = ToBeClassified;
        }
        field(6; "New Employee No."; Code[10])
        {
            Caption = 'New Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get("New Employee No.")then begin
                    "New Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Transfer Branch":=Employee."Global Dimension 1 Code";
                    "Transfer Department":=Employee."Global Dimension 2 Code";
                end;
            end;
        }
        field(7; "New Employee Name"; Text[100])
        {
            Caption = 'New Employee Name';
            DataClassification = ToBeClassified;
        }
        field(8; "Current Branch"; Code[50])
        {
            Caption = 'Current Branch';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(9; "Current Department"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
        }
        field(10; "Transfer Branch"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(11; "Transfer Department"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(12; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Transfer, "Initial Allocation";
        }
        field(13; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Asset Condition"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Serial No."; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Allocated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Transferred; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Car Registration No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(20; Status; Option)
        {
            OptionMembers = Open, "Pending Approval", Released, Rejected;
            DataClassification = ToBeClassified;
        }
        field(21; "Tag Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Chasis Number"; Code[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Engine Number"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(24; Acknowledge; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        HrSetup.Get();
        case Type of type::"Initial Allocation": begin
            HrSetup.TestField("Asset Allocation Nos");
            if "No." = '' then NoSeriesMgt.InitSeries(HrSetup."Asset Allocation Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        type::Transfer: begin
            HrSetup.TestField("Asset Transfer Nos");
            if "No." = '' then NoSeriesMgt.InitSeries(HrSetup."Asset Transfer Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        end;
    end;
    var HrSetup: Record "Human Resources Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
