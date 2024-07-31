table 50149 "Item Transfer"
{
    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Item; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;

            trigger OnValidate()
            begin
                if Items.Get(Item)then begin
                    Description:=Items.Description;
                    Items.CalcFields(Inventory);
                    Inventory:=Items.Inventory;
                end;
            end;
        }
        field(3; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Receiving Employee"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                TESTFIELD("Company To");
                
                Employee2.CHANGECOMPANY("Company To");
                CLEAR(EmployeeList);
                EmployeeList.SETTABLEVIEW(Employee2);
                EmployeeList.SETRECORD(Employee2);
                EmployeeList.LOOKUPMODE(TRUE);
                IF EmployeeList.RUNMODAL=ACTION::LookupOK THEN
                  BEGIN
                    EmployeeList.GETRECORD(Employee2);
                    "Receiving Name":=Employee2."First Name"+' '+Employee2."Middle Name"+' '+Employee2."Last Name";
                  END;
                */
            /*
                Employee2.SETRANGE("No.","Receiving Employee");
                IF Employee2.FINDFIRST THEN
                  BEGIN
                    "Receiving Name":=Employee2."First Name"+' '+Employee2."Middle Name"+' '+Employee2."Last Name";
                  END;
                
                
                
                PurchHeader2.CHANGECOMPANY('New company');
                PurchHeader2.SETRANGE("Document Type",PurchHeader2."Document Type"::Order);
                CLEAR(PurchList);
                PurchList.SETTABLEVIEW(PurchHeader2);
                PurchList.SETRECORD(PurchHeader2);
                PurchList.LOOKUPMODE(TRUE);
                IF PurchList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                PurchList.GETRECORD(PurchHeader2);
                PONumber := PurchHeader2."No.";
                END;
                */
            end;
        }
        field(9; "Receiving Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Company To"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Company;
        }
        field(11; "Company From"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Transfered; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Inventory; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Location From"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(17; "Location To"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Company Item"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Company Item Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        PurchSetup.Get;
        PurchSetup.TestField("Store Transfer Nos");
        NoSeriesMgt.InitSeries(PurchSetup."Store Transfer Nos", xRec."No. Series", 0D, No, "No. Series");
        "User ID":=UserId;
        if UserSetup.Get("User ID")then begin
            if Employee.Get(UserSetup."Employee No.")then begin
                "Employee No":=Employee."No.";
                "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        end;
        Date:=Today;
        "Company From":=CompanyName;
    end;
    var PurchSetup: Record "Purchases & Payables Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UserSetup: Record "User Setup";
    Employee: Record Employee;
    Items: Record Item;
    Employee2: Record Employee;
    EmployeeList: Page "Employee List";
}
