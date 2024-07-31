page 50617 "Training Needs Request"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Training Needs Request";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Source Document No"; Rec."Source Document No")
                {
                    Enabled = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Enabled = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field("Training Name"; Rec."Training Name")
                {
                    ApplicationArea = All;
                }
                field("Training area"; Rec."Training area")
                {
                    ApplicationArea = All;
                }
                field("Training Objectives"; Rec."Training Objectives")
                {
                    ApplicationArea = All;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = All;
                }
                field(Provider; Rec.Provider)
                {
                    ApplicationArea = All;
                }
                field("Need Source"; Rec."Need Source")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
        }
    }
}
