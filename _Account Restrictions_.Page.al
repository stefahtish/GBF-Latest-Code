page 51338 "Account Restrictions"
{
    ApplicationArea = All;
    Caption = 'Account Restrictions';
    PageType = List;
    SourceTable = "Account Restrictions";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Userid; Rec.Userid)
                {
                    ToolTip = 'Specifies the value of the Userid field.', Comment = '%';
                }
                field("Gl Account"; Rec."Gl Account")
                {
                    ToolTip = 'Specifies the value of the Gl Account field.', Comment = '%';
                }
            }
        }
    }
}
