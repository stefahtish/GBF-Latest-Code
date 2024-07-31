page 50622 "Training Evaluation List"
{
    ApplicationArea = All;
    PageType = List;
    CardPageId = "Training Evaluation Card";
    SourceTable = "Training Evaluation Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Training Evaluation No."; Rec."Training Evaluation No.")
                {
                    ApplicationArea = All;
                }
                field("Personal No."; Rec."Personal No.")
                {
                    ApplicationArea = All;
                }
                field("Name of the participant"; Rec."Name of participant")
                {
                    ApplicationArea = All;
                }
                field("Training Name"; Rec."Training Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
