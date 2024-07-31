page 51179 "Audit Perfomance Indicators"
{
    Caption = 'Perfomance Indicators';
    PageType = ListPart;
    SourceTable = "Audit Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Indicator; Rec.Indicator)
                {
                    ToolTip = 'Specifies the value of the Indicator field';
                    ApplicationArea = All;
                }
                field(Target; Rec.Target)
                {
                    ToolTip = 'Specifies the value of the Target field';
                    ApplicationArea = All;
                }
            }
        }
    }
}
