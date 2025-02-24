table 50276 "Customized Calendar Change II"
{
    Caption = 'Customized Calendar Change';

    fields
    {
        field(1; "Source Type"; Option)
        {
            Caption = 'Source Type';
            Editable = false;
            OptionCaption = 'Company,Customer,Vendor,Location,Shipping Agent,Service';
            OptionMembers = Company, Customer, Vendor, Location, "Shipping Agent", Service;
        }
        field(2; "Source Code"; Code[20])
        {
            Caption = 'Source Code';
            Editable = false;
        }
        field(3; "Additional Source Code"; Code[20])
        {
            Caption = 'Additional Source Code';
        }
        field(4; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            Editable = false;
            TableRelation = "Base Calender Custom";
        }
        field(5; "Recurring System"; Option)
        {
            Caption = 'Recurring System';
            OptionCaption = ' ,Annual Recurring,Weekly Recurring';
            OptionMembers = " ", "Annual Recurring", "Weekly Recurring";

            trigger OnValidate()
            begin
                if "Recurring System" <> xRec."Recurring System" then case "Recurring System" of "Recurring System"::"Annual Recurring": Day:=Day::" ";
                    "Recurring System"::"Weekly Recurring": Date:=0D;
                    end;
            end;
        }
        field(6; Date; Date)
        {
            Caption = 'Date';

            trigger OnValidate()
            begin
                if("Recurring System" = "Recurring System"::" ") or ("Recurring System" = "Recurring System"::"Annual Recurring")then TestField(Date)
                else
                    TestField(Date, 0D);
                UpdateDayName;
            end;
        }
        field(7; Day; Option)
        {
            Caption = 'Day';
            OptionCaption = ' ,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
            OptionMembers = " ", Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday;

            trigger OnValidate()
            begin
                if "Recurring System" = "Recurring System"::"Weekly Recurring" then TestField(Day);
                UpdateDayName;
            end;
        }
        field(8; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(9; Nonworking; Boolean)
        {
            Caption = 'Nonworking';
            InitValue = true;
        }
        field(10; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
    }
    keys
    {
        key(Key1; "Source Type", "Source Code", "Additional Source Code", "Base Calendar Code", "Recurring System", Date, Day, "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Entry No.")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Source Type", "Source Code", "Additional Source Code")
        {
        }
    }
    trigger OnInsert()
    begin
        CheckEntryLine;
    end;
    trigger OnModify()
    begin
        CheckEntryLine;
    end;
    trigger OnRename()
    begin
        CheckEntryLine;
    end;
    var Customer: Record Customer;
    Vendor: Record Vendor;
    Location: Record Location;
    ShippingAgentService: Record "Shipping Agent Services";
    DateTable: Record Date;
    ServMgtSetup: Record "Service Mgt. Setup";
    procedure GetCaption(): Text[250]begin
        case "Source Type" of "Source Type"::Company: exit(CompanyName);
        "Source Type"::Customer: if Customer.Get("Source Code")then exit("Source Code" + ' ' + Customer.Name);
        "Source Type"::Vendor: if Vendor.Get("Source Code")then exit("Source Code" + ' ' + Vendor.Name);
        "Source Type"::Location: if Location.Get("Source Code")then exit("Source Code" + ' ' + Location.Name);
        "Source Type"::"Shipping Agent": if ShippingAgentService.Get("Source Code", "Additional Source Code")then exit("Source Code" + ' ' + "Additional Source Code" + ' ' + ShippingAgentService.Description);
        "Source Type"::Service: if ServMgtSetup.Get then exit("Source Code" + ' ' + ServMgtSetup.TableCaption);
        end;
    end;
    local procedure UpdateDayName()
    begin
        if(Date > 0D) and ("Recurring System" = "Recurring System"::"Annual Recurring")then Day:=Day::" "
        else
        begin
            DateTable.SetRange("Period Type", DateTable."Period Type"::Date);
            DateTable.SetRange("Period Start", Date);
            if DateTable.FindFirst then Day:=DateTable."Period No.";
        end;
        if(Date = 0D) and (Day = Day::" ")then begin
            Day:=xRec.Day;
            Date:=xRec.Date;
        end;
        if "Recurring System" = "Recurring System"::"Annual Recurring" then TestField(Day, Day::" ");
    end;
    local procedure CheckEntryLine()
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
