table 50482 "Email/SMS Logging Lines"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Item Sent"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Sent; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Error Message"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "User Password"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Owner Password"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "SMS Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "SMS Error Message"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Phone Number"; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Email Address"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Client Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Member,Sponsor';
            OptionMembers = Member, Sponsor;
        }
        field(14; Client; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Category; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Vendor,Customer,Student,Staff,Contact,Members';
            OptionMembers = " ", Vendor, Customer, Student, Staff, Contact, Members;
        }
        field(16; "Recipient No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF(Category=FILTER(Members))Vendor."No."
            ELSE IF(Category=FILTER(Vendor))Vendor."No."
            ELSE IF(Category=FILTER(Staff))Employee."No."
            ELSE IF(Category=FILTER(Contact))Contact."No.";

            trigger OnValidate()
            begin
            // CASE Category OF
            //  Category::Contact:
            //    BEGIN
            //      Contact.GET("Recipient No.");
            //      "Recipient Name":=Contact.Name;
            //    END;
            //  Category::Customer:
            //    BEGIN
            //      Customer.GET("Recipient No.");
            //      "Recipient Name":=Customer.Name;
            //    END;
            //  Category::Staff:
            //    BEGIN
            //      Employee.GET("Recipient No.");
            //      "Recipient Name":=Employee.Name;
            //    END;
            //  Category::Vendor,Category::Members:
            //    BEGIN
            //      Vendor.GET("Recipient No.");
            //      "Recipient Name":=Vendor.Name;
            //    END;
            // END;
            end;
        }
        field(17; "Recipient Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Recipient E-Mail"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Recipient Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "E-Mail Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.", Category, "Recipient No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Employee: Record Employee;
    Customer: Record Customer;
    Vendor: Record Vendor;
    Contact: Record Contact;
}
