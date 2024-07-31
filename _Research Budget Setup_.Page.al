page 51099 "Research Budget Setup"
{
    Caption = 'Research Budget Setup';
    PageType = List;
    SourceTable = "Research Budget Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Activity Code"; Rec."Activity Code")
                {
                    Caption = 'Budget Code';
                    ToolTip = 'Specifies the value of the Activity Code field';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                }
                field("Promotion Activities"; Rec."Promotion Activities")
                {
                }
                field("Stakeholder support"; Rec."Stakeholder support")
                {
                }
                field("Dairy Standards"; Rec."Dairy Standards")
                {
                }
                field("Partnersip Activities"; Rec."Partnersip Activities")
                {
                }
                field("Research and Survey"; Rec."Research and Survey")
                {
                }
            }
        }
    }
}
