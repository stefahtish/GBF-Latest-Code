page 51285 "Vendor Evaluation List"
{
    CardPageID = "Vendor Evaluation Card";
    caption = 'Supplier Performance Evaluation List';
    //DeleteAllowed = false;
    PageType = List;
    SourceTable = "Supplier Evaluation Header";
    SourceTableView = where(Type = const(Existing));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Quote No"; Rec."Quote No")
                {
                    Caption = 'Tender No.';
                }
                field(Title; Rec.Title)
                {
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                }
                field(User; Rec.User)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Type; Rec.Type)
                {
                }
            }
        }
    }
    // trigger OnOpenPage()
    // var
    //     UserSetup: record "User Setup";
    // begin
    //     if UserSetup.Get(UserId) then begin
    //         if not UserSetup."Show All" then begin
    //             FilterGroup(2);
    //             SetRange(User, UserId);
    //         end;
    //     end else
    //         Error('%1 does not exist in the Users Setup', UserId);
    // end;
}
