page 51293 "Appraisal Performance Factors"
{
    Caption = 'Performance Factors';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Appraisal Performance Factors";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(code; Rec.code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
