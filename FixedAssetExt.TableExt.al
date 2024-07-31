tableextension 50166 FixedAssetExt extends "Fixed Asset"
{
    fields
    {
        modify("Responsible Employee")
        {
        trigger OnAfterValidate()
        var
            Emp: Record Employee;
        begin
            if Emp.get("Responsible Employee")then "Employee Name":=Emp."First Name" + ' ' + Emp."Last Name";
        end;
        }
        field(50004; Bookable; Boolean)
        {
        }
        field(50005; "Link Type"; option)
        {
            OptionCaption = 'All,Investment';
            OptionMembers = All, Investment;
        }
        field(50007; Colour; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50008; "Type of Body"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50009; "Chassis No."; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50010; Rating; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50011; "Seating/carrying capacity"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50012; "Registration No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50138; Disposed; Boolean)
        {
            CalcFormula = Exist("FA Depreciation Book" WHERE("FA No."=FIELD("No."), "Disposal Date"=FILTER(<>0D)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50139; "Marked For Disposal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60005; "Date of purchase"; Date)
        {
        }
        field(60081; Body; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60082; "Car Tracking Company"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60083; "Tracking Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60084; "Tracking Renewal Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60085; "Car Rating"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60086; YOM; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60087; Duty; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60031; "Policy No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60032; Insurer; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60033; "Insurance Company"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60034; "Premium Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60035; "Amount of Purchase"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60036; "Valuation Firm"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60037; "Last Valued Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60038; "Date of Commencement"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60039; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60040; "Fixed Asset Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
            OptionCaption = ' ,Fleet,House';
            OptionMembers = " ", Fleet, House;
        }
        field(60041; "Current Odometer Reading"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60042; "On Trip"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60043; "In Use"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60044; "Tank Capacity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60045; "Average Km/L"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60046; "Logbook No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(60047; "Maintainence Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Available, "Under Maintenence", "Written Off";
        }
        field(60051; Make; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(60053; Model; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(51521022; Valuer; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Property';
        }
        field(51521023; "Employee Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51521024; NetBookValue; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("FA Ledger Entry".Amount WHERE("FA No."=FIELD("No."), "Part of Book Value"=CONST(true), "FA Posting Date"=FIELD("FA Posting Date Filter")));
        }
        field(51521025; OriginalValue; Decimal)
        {
        // FieldClass = FlowField;
        // CalcFormula = max("FA Depreciation Book"."Book Value" where("FA No." = field("No.")));
        }
        field(51520126; "Vehicle Type"; Option)
        {
            OptionCaption = ' ,Company Vehicle,Personal Vehicle';
            OptionMembers = " ", Company, Personal;
            DataClassification = ToBeClassified;
        }
        field(51520127; "Tag Number"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Tag Number" <> xRec."Tag Number" then begin
                    CashMgt.get;
                    CashMgt.TestField("Tag Nos");
                    NoSeriesMgt.TestManual(CashMgt."Tag Nos");
                end;
            end;
        }
        field(51520128; "Card No"; Code[300])
        {
            DataClassification = ToBeClassified;
        }
        field(51520129; "Inspection Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(51520130; "Hotline No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(51520131; Lab; Boolean)
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("Dimension Value".Lab where(Code = field("Global Dimension 2 Code")));
            obsoletestate = removed;
        }
        field(51520132; "Engine No."; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(51520133; "Registration Type"; Option)
        {
            OptionCaption = ' ,Commercial Vehicle,Private Vehicle';
            OptionMembers = " ", Commercial, Private;
            DataClassification = ToBeClassified;
        }
        field(51520134; "FA Subcategory"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "FA Subcategories".Subcategory where(Subclass=field("FA Subclass Code"));
        }
        field(51520135; Computer; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("FA Subclass".Computer where(Code=field("FA Subclass Code")));
        }
        field(51520136; "Next Service Mileage"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(51520137; "Card balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Fuel Allocation Ledger Entries".Amount where("Card No"=field("Card No")));
        }
        field(51520138; "Asset Condition"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnAfterInsert()
    begin
        if "Tag Number" = '' then begin
            CashMgt.get;
            CashMgt.TestField("Tag Nos");
            NoSeriesMgt.InitSeries(CashMgt."Tag Nos", xRec."No. Series", 0D, "Tag Number", "No. Series")end;
    end;
    var CashMgt: Record "Cash Management Setups";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
