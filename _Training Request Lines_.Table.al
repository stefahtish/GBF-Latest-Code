table 50302 "Training Request Lines"
{
    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Training Request";
        }
        field(2; "Training Need No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Training Need";
        }
        field(3; "Expense Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Training Needs Lines"."Expense Code" WHERE("Document No."=FIELD("Training Need No"));

            trigger OnValidate()
            begin
                TrainingNeedsLines.Reset;
                TrainingNeedsLines.SetRange("Document No.", "Training Need No");
                TrainingNeedsLines.SetRange("Expense Code", "Expense Code");
                if TrainingNeedsLines.FindFirst then begin
                    "G/L Account":=TrainingNeedsLines."G/L Account";
                    "Expense Name":=TrainingNeedsLines."Expense name";
                end;
            end;
        }
        field(4; "G/L Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Per Diem" then Error(Text001);
                CurrencyRec.InitRoundingPrecision;
                if "Currency Code" = '' then "Amount (LCY)":=Round(Amount, CurrencyRec."Amount Rounding Precision")
                else
                    "Amount (LCY)":=Round(CurrencyExchangeRate.ExchangeAmtFCYToLCY(Today, "Currency Code", Amount, CurrencyExchangeRate.ExchangeRate(Today, "Currency Code")), CurrencyRec."Amount Rounding Precision");
            end;
        }
        field(6; "Amount (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(8; Committed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Per Diem"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Status; Option)
        {
            CalcFormula = Lookup("Training Request".Status WHERE("Request No."=FIELD("Document No.")));
            FieldClass = FlowField;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open, Released, "Pending Approval", "Pending Prepayment";
        }
        field(11; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(12; "Expense Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Document No.", "Training Need No", "Expense Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        TrainingRequest.Get("Document No.");
        TrainingRequest.TestField("Employee No");
        "Employee No":="Employee No";
    end;
    var CurrencyRec: Record Currency;
    CurrencyExchangeRate: Record "Currency Exchange Rate";
    Text001: Label 'You cannot edit Per Diem Amount.';
    TrainingRequest: Record "Training Request";
    TrainingNeedsLines: Record "Training Needs Lines";
}
