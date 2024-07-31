page 51418 "Contract Terms And Conditions"
{
    ApplicationArea = All;
    Caption = 'Contract Terms And Conditions';
    PageType = List;
    SourceTable = "Contract Terms And Conditions";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Terms and Condition"; Rec."Terms and Condition")
                {
                    caption = 'Code';
                    ToolTip = 'Specifies the value of the Terms and Condition field.';
                    ApplicationArea = All;
                }
                field("Terms & Condition Description"; Rec."Terms & Condition Description")
                {
                    ToolTip = 'Specifies the value of the Terms & Condition Description field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
