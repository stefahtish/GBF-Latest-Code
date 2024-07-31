table 50472 "Interaction Setup"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Client Interaction Type Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3; "Client Interaction Cause Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(4; "Interaction Resolution Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(5; "Client Interaction Header Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(6; "Client Record Change Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(7; "Employer Inter. Header Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(8; "Staff Interaction Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(9; "Archive Period Type"; Option)
        {
            OptionCaption = ',Days,Weeks,Months,Years';
            OptionMembers = , Days, Weeks, Months, Years;
        }
        field(10; "Archive Period"; DateFormula)
        {
        }
        field(11; "Interaction Administrator"; Text[80])
        {
        }
        field(12; "Admin Email"; Text[80])
        {
        }
        field(13; "Notifications Period"; DateFormula)
        {
        }
        field(14; "Registry Email"; Text[50])
        {
        }
        field(15; "Operations Email"; Text[50])
        {
        }
        field(16; "Assign Claims to Oper./ Branch"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Auto Assigns Claims to Operations Department Per Branch';

            trigger OnValidate()
            begin
                if("Assign Claims to Oper./ Branch" = true)then if("Auto Assign on Operations" = false) and ("Auto Assign on Registry" = false)then Error(Text00001);
            end;
        }
        field(17; "Auto Assign on Registry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Auto Assigns Claims at Registry Level';

            trigger OnValidate()
            begin
                if "Auto Assign on Registry" and "Auto Assign on Operations" then;
                "Auto Assign on Operations":=false;
                if("Auto Assign on Registry" = false) and ("Auto Assign on Operations" = false)then;
                "Assign Claims to Oper./ Branch":=false;
            end;
        }
        field(18; "Auto Assign on Operations"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Auto Assigns Claims at Registry Level';

            trigger OnValidate()
            begin
                if "Auto Assign on Operations" and "Auto Assign on Registry" then;
                "Auto Assign on Registry":=false;
                if("Auto Assign on Operations" = false) and ("Auto Assign on Registry" = false)then;
                "Assign Claims to Oper./ Branch":=false;
            end;
        }
        field(19; "Auto Create RBB/Claim on Reg."; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Creates RBB or Claim when the interation is sent to Registry';

            trigger OnValidate()
            begin
                if "Auto Create RBB/Claim on Reg." and "Auto Create RBB/Claim on Oper." then;
                "Auto Create RBB/Claim on Oper.":=false;
            end;
        }
        field(20; "Auto Create RBB/Claim on Oper."; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Creates RBB or Claim when the interation is sent to Operations';

            trigger OnValidate()
            begin
                if "Auto Create RBB/Claim on Oper." and "Auto Create RBB/Claim on Reg." then;
                "Auto Create RBB/Claim on Reg.":=false;
            end;
        }
        field(21; "MD Email"; Text[200])
        {
        }
        field(22; "Client Commuication Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Text00001: Label 'Please select one of the Auto Assign options. Either Auto Assign at Registry or Operations';
}
