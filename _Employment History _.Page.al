page 50427 "Employment History "
{
    PageType = ListPart;
    SourceTable = "Employment History";
    SourceTableView = SORTING(From, To) ORDER(Descending);
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Company Name"; Rec."Company Name")
                {
                }
                field(From; Rec.From)
                {
                }
                field("To"; Rec."To")
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                }
                field("Key Experience"; Rec."Key Experience")
                {
                }
                field("Salary On Leaving"; Rec."Salary On Leaving")
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                }
                field("Reason For Leaving"; Rec."Reason For Leaving")
                {
                }
                field(Current; Rec.Current)
                {
                }
            }
        }
    }
    actions
    {
    }
}
