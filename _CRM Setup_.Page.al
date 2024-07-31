page 50853 "CRM Setup"
{
    PageType = Card;
    SourceTable = "Interaction Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Client Interaction Type Nos."; Rec."Client Interaction Type Nos.")
                {
                }
                field("Client Interaction Cause Nos."; Rec."Client Interaction Cause Nos.")
                {
                }
                field("Interaction Resolution Nos."; Rec."Interaction Resolution Nos.")
                {
                }
                field("Client Interaction Header Nos."; Rec."Client Interaction Header Nos.")
                {
                }
                field("Client Record Change Nos."; Rec."Client Record Change Nos.")
                {
                }
                field("Client Commuication Nos."; Rec."Client Commuication Nos.")
                {
                }
                field("Employer Inter. Header Nos."; Rec."Employer Inter. Header Nos.")
                {
                }
                field("Registry Email"; Rec."Registry Email")
                {
                }
                field("Operations Email"; Rec."Operations Email")
                {
                }
                field("MD Email"; Rec."MD Email")
                {
                    ApplicationArea = All;
                }
                field("Auto Assign on Operations"; Rec."Auto Assign on Operations")
                {
                }
                field("Auto Assign on Registry"; Rec."Auto Assign on Registry")
                {
                }
                field("Assign Claims to Oper./ Branch"; Rec."Assign Claims to Oper./ Branch")
                {
                }
                field("Auto Create RBB/Claim on Reg."; Rec."Auto Create RBB/Claim on Reg.")
                {
                    ToolTip = 'This auto creates the RBB or Claim when the Interaction Document is sent to Registry for processing from CRM Logs.';
                }
                field("Auto Create RBB/Claim on Oper."; Rec."Auto Create RBB/Claim on Oper.")
                {
                    ToolTip = 'This auto creates the RBB or Claim when the Interaction Document is sent to Operations for processing from Registry.';
                }
            }
        }
    }
    actions
    {
    }
}
