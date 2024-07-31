page 51085 "Sample Retention Conditions"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Laboratory Setup Type";
    SourceTableView = where(Type=const("Sample Retention Conditions"));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Option; Rec.Options)
                {
                    Caption = 'Has options?';
                    ApplicationArea = All;
                }
                field("Is Retention Period"; Rec."Is Retention Period")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {
        }
    }
    actions
    {
        area(Processing)
        {
            action(Options)
            {
                Image = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page "Sample Conditions Options";
                Visible = Rec.Options;
                RunPageLink = Condition=field(Name);
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec.Type:=Rec.Type::"Sample Retention Conditions";
    end;
}
