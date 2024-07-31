page 51258 "Risk KRI Guideline Setup"
{
    PageType = List;
    SourceTable = "Risk KRI Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                ShowCaption = false;

                field("Family of KRI Ref"; Rec."Family of KRI Ref")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Indicator; Rec.Indicator)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(BASIS; Rec.BASIS)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Trigger Option"; Rec.TriggerOption)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Qualitative; Rec.Qualitative)
                {
                    Editable = Rec.TriggerOption = Rec.TriggerOption::Qualitative;
                    ApplicationArea = Basic, Suite;
                }
                field(Quantitative; Rec.TriggerValue)
                {
                    Editable = Rec.TriggerOption = Rec.TriggerOption::Quantitative;
                    ApplicationArea = Basic, Suite;
                }
                field(TriggerStatus; Rec.TriggerStatus)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field(IndicativeUnits; Rec.IndicativeUnits)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    actions
    {
    }
}
