table 50229 "Base Calender Change Custom"
{
    fields
    {
        field(1; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "Base Calender Custom";
        }
        field(2; "Recurring System"; Option)
        {
            Caption = 'Recurring System';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Annual Recurring,Weekly Recurring';
            OptionMembers = " ", "Annual Recurring", "Weekly Recurring";

            trigger OnValidate()
            begin
                if "Recurring System" <> xRec."Recurring System" then case "Recurring System" of "Recurring System"::"Annual Recurring": Day:=Day::" ";
                    "Recurring System"::"Weekly Recurring": Date:=0D;
                    end;
            end;
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if("Recurring System" = "Recurring System"::" ") or ("Recurring System" = "Recurring System"::"Annual Recurring")then TestField(Date)
                else
                    TestField(Date, 0D);
                UpdateDayName;
            end;
        }
        field(4; Day; Option)
        {
            Caption = 'Day';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
            OptionMembers = " ", Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday;

            trigger OnValidate()
            begin
                if "Recurring System" = "Recurring System"::"Weekly Recurring" then TestField(Day);
                UpdateDayName;
            end;
        }
        field(5; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; Nonworking; Boolean)
        {
            Caption = 'Nonworking';
            DataClassification = ToBeClassified;
            InitValue = true;
        }
    }
    keys
    {
        key(Key1; "Base Calendar Code", "Recurring System", Date, Day)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    procedure UpdateDayName()
    var
        DateTable: Record Date;
    begin
        if(Date > 0D) and ("Recurring System" = "Recurring System"::"Annual Recurring")then Day:=Day::" "
        else
        begin
            DateTable.SetRange("Period Type", DateTable."Period Type"::Date);
            DateTable.SetRange("Period Start", Date);
            if DateTable.Find('-')then Day:=DateTable."Period No.";
        end;
        if(Date = 0D) and (Day = Day::" ")then begin
            Day:=xRec.Day;
            Date:=xRec.Date;
        end;
        if "Recurring System" = "Recurring System"::"Annual Recurring" then TestField(Day, Day::" ");
    end;
    procedure CheckEntryLine()
    begin
        case "Recurring System" of "Recurring System"::" ": begin
            TestField(Date);
            TestField(Day);
        end;
        "Recurring System"::"Annual Recurring": begin
            TestField(Date);
            TestField(Day, Day::" ");
        end;
        "Recurring System"::"Weekly Recurring": begin
            TestField(Date, 0D);
            TestField(Day);
        end;
        end;
    end;
}
