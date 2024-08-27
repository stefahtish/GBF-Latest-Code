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
                if Emp.get("Responsible Employee") then "Employee Name" := Emp."First Name" + ' ' + Emp."Last Name";
            end;
        }
        field(50004; Bookable; Boolean)
        {
        }
        field(50005; "Link Type"; option)
        {
            OptionCaption = 'All,Investment';
            OptionMembers = All,Investment;
        }
        field(50006; Colour; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50007; "Type of Body"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50008; "Chassis No."; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50009; Rating; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50010; "Seating/carrying capacity"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50011; "Registration No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50012; Disposed; Boolean)
        {
            CalcFormula = Exist("FA Depreciation Book" WHERE("FA No." = FIELD("No."), "Disposal Date" = FILTER(<> 0D)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50013; "Marked For Disposal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Date of purchase"; Date)
        {
        }
        field(50015; Body; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50016; "Car Tracking Company"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50017; "Tracking Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50018; "Tracking Renewal Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50019; "Car Rating"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50020; YOM; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50021; Duty; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50022; "Policy No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50023; Insurer; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50024; "Insurance Company"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50025; "Premium Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50026; "Amount of Purchase"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Valuation Firm"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50028; "Last Valued Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50029; "Date of Commencement"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50030; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50031; "Fixed Asset Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
            OptionCaption = ' ,Fleet,House';
            OptionMembers = " ",Fleet,House;
        }
        field(50032; "Current Odometer Reading"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50033; "On Trip"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50034; "In Use"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50035; "Tank Capacity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50036; "Average Km/L"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50037; "Logbook No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Maintainence Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Available,"Under Maintenence","Written Off";
        }
        field(50039; Make; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50040; Model; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50041; Valuer; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Property';
        }
        field(50042; "Employee Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50043; NetBookValue; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("FA Ledger Entry".Amount WHERE("FA No." = FIELD("No."), "Part of Book Value" = CONST(true), "FA Posting Date" = FIELD("FA Posting Date Filter")));
        }
        field(50044; OriginalValue; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = max("FA Depreciation Book"."Book Value" where("FA No." = field("No.")));
        }
        field(50045; "Vehicle Type"; Option)
        {
            OptionCaption = ' ,Company Vehicle,Personal Vehicle';
            OptionMembers = " ",Company,Personal;
            DataClassification = ToBeClassified;
        }
        field(50046; "Tag Number"; Code[10])
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
        field(50047; "Card No"; Code[300])
        {
            DataClassification = ToBeClassified;
        }
        field(50048; "Inspection Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50049; "Hotline No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50050; Lab; Boolean)
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("Dimension Value".Lab where(Code = field("Global Dimension 2 Code")));
            obsoletestate = removed;
        }
        field(50051; "Engine No."; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50052; "Registration Type"; Option)
        {
            OptionCaption = ' ,Commercial Vehicle,Private Vehicle';
            OptionMembers = " ",Commercial,Private;
            DataClassification = ToBeClassified;
        }
        field(50053; "FA Subcategory"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "FA Subcategories".Subcategory where(Subclass = field("FA Subclass Code"));
        }
        field(50054; Computer; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("FA Subclass".Computer where(Code = field("FA Subclass Code")));
        }
        field(50055; "Next Service Mileage"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'fleet';
        }
        field(50056; "Card balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Fuel Allocation Ledger Entries".Amount where("Card No" = field("Card No")));
        }
        field(50057; "Asset Condition"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnAfterInsert()
    begin
        if "Tag Number" = '' then begin
            CashMgt.get;
            CashMgt.TestField("Tag Nos");
            NoSeriesMgt.InitSeries(CashMgt."Tag Nos", xRec."No. Series", 0D, "Tag Number", "No. Series");
        end;
    end;

    var
        CashMgt: Record "Cash Management Setups";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
