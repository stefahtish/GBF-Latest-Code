page 50738 "Appraisal Preamble Setup"
{
    ApplicationArea = All;
    Caption = 'Appraisal Preamble Setup';
    PageType = List;
    SourceTable = "Appraisal Preamble Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("SNo."; Rec."SNo.")
                {
                    ToolTip = 'Specifies the value of the SNo. field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
