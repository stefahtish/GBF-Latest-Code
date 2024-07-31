table 50120 "Destination Rate Entry"
{
    fields
    {
        field(1; "Advance Code"; Code[20])
        {
            Caption = 'Expenditure Type';
            NotBlank = true;
            TableRelation = IF("Payment Type"=FILTER(Imprest))"Receipts and Payment Types".Code WHERE(Type=FILTER(Imprest))
            ELSE IF("Payment Type"=FILTER("Staff Claim"))"Receipts and Payment Types".Code WHERE(Type=FILTER(Claim))
            ELSE IF("Payment Type"=FILTER("Staff Advance"))"Receipts and Payment Types".Code WHERE(Type=FILTER(Advance))
            ELSE
            "Receipts and Payment Types".Code;
        }
        field(2; "Destination Code"; Code[10])
        {
            NotBlank = true;
            TableRelation = Destination;

            trigger OnValidate()
            var
                Destination: Record Destination;
            begin
                Destination.Reset();
                Destination.Get("Destination Code");
                "Destination Name":=Destination."Destination Name";
                "Other Area":=Destination."Other Area";
                "Destination Type":=Destination."Destination Type";
            end;
        }
        field(3; Currency; Code[10])
        {
            NotBlank = false;
            TableRelation = Currency;
        }
        field(4; "Destination Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Local,Foreign';
            OptionMembers = "local", Foreign;
        }
        field(5; "Daily Rate (Amount)"; Decimal)
        {
        }
        field(6; "Employee Job Group"; Code[10])
        {
            Editable = true;
            NotBlank = true;
            TableRelation = "Salary Scale".Scale;
        }
        field(7; "Destination Name"; Text[50])
        {
            Editable = false;
        }
        field(8; "Other Area"; Boolean)
        {
            Editable = false;
        }
        field(9; "Rate Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Payments,Training';
            OptionMembers = Payments, Training;
        }
        field(10; "Payment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Payment Voucher,Imprest,Staff Claim,Imprest Surrender,Petty Cash,Bank Transfer,Petty Cash Surrender,Receipt,Staff Advance,Receipt-Property';
            OptionMembers = "Payment Voucher", Imprest, "Staff Claim", "Imprest Surrender", "Petty Cash", "Bank Transfer", "Petty Cash Surrender", Receipt, "Staff Advance", "Receipt-Property";
        }
    }
    keys
    {
        key(Key1; "Destination Code", "Employee Job Group", Currency, "Advance Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
