table 50532 "Payment Schedule"
{
    fields
    {
        field(1; "Contract No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(2; Activity; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Delivarable; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Deliverable';
        }
        field(4; "Payment %"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcFields("Payment Sum %");
                Schdl.Reset;
                Schdl.SetRange("Contract No.", "Contract No.");
                if Schdl.FindLast then begin
                    CalcFields("Payment Sum %");
                    if "Payment Sum %" > 100 then Error(Text001);
                end;
            end;
        }
        field(5; "Schedule No."; Integer)
        {
            AutoIncrement = false;
            DataClassification = ToBeClassified;
        }
        field(6; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Accepted,Not Due';
            OptionMembers = Accepted, "Not Due";

            trigger OnValidate()
            begin
                if Rec.Status = Rec.Status::Accepted then begin
                    "Paid Amount":=Amount;
                    Modify;
                end
                else
                    "Paid Amount":=0;
                Modify;
            end;
        }
        field(7; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Rec.Status = Rec.Status::Accepted then "Paid Amount":=Amount;
                Modify;
            end;
        }
        field(8; "No. Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Payment Sum %"; Decimal)
        {
            CalcFormula = Sum("Payment Schedule"."Payment %" WHERE("Contract No."=FIELD("Contract No.")));
            FieldClass = FlowField;
        }
        field(10; Paid; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Paid Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Rec.Status = Rec.Status::Accepted then "Paid Amount":=Amount;
                Modify;
            end;
        }
        field(12; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Contract No.", "Schedule No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
    // Schdl.RESET;
    // Schdl.SETRANGE("Contract No.",Rec."Contract No.");
    // Schdl.SETCURRENTKEY("Schedule No.");
    // IF Schdl.FINDLAST THEN
    //  "Schedule No.":=(Schdl."Schedule No."+1)
    // ELSE
    //  "Schedule No."+=1;
    end;
    var HRSetup: Record "Human Resources Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UserSetup: Record "User Setup";
    Empl: Record Employee;
    FA: Record "Fixed Asset";
    Transport: Record "Travelling Employee";
    Dim: Record "Dimension Value";
    DimMgt: Codeunit DimensionManagement;
    Schdl: Record "Payment Schedule";
    Text001: Label 'Payment must add up to 100%';
    Schedule: Record "Payment Schedule";
}
