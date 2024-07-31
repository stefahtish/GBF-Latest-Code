page 50881 "Dispatched Letter Register Lis"
{
    CardPageID = "New Mail";
    PageType = List;
    SourceTable = "Dispatched Letter Register";
    SourceTableView = WHERE(Dispartched = CONST(false));
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
                field(Date; Rec.Date)
                {
                }
                field(From; Rec.From)
                {
                }
                field(Subject; Rec.Subject)
                {
                }
                field("Dispatch Date"; Rec."Dispatch Date")
                {
                }
                field("Action Officer1 Name"; Rec."Action Officer1 Name")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Remarks/ FILE No."; Rec."Remarks/ FILE No.")
                {
                }
                field("Action Officer2 Name"; Rec."Action Officer2 Name")
                {
                }
                field("Action Officer3 Name"; Rec."Action Officer3 Name")
                {
                }
                field("Action Officer4 Name"; Rec."Action Officer 4 Name")
                {
                }
                field(Dispartched; Rec.Dispartched)
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Send to Registry")
            {
                trigger OnAction()
                begin
                    RSetup.Get;
                    RSetup.TestField("Resource Admin");
                    if UserSetup.Get(UserId) then SenderAddress := UserSetup."E-Mail";
                    if UserSetup.Get(RSetup."Resource Admin") then Recepient.Add(UserSetup."E-Mail");
                    Body := StrSubstNo('Please confirm the reception of the Letter No % 1 ', Rec."No.");
                    SMTP.Create(Recepient, 'LETTERS', Body, true);
                    Email.Send(SMTP);
                    Rec.Send := true;
                    Rec.Sender := UserId;
                    Rec.Modify;
                end;
            }
            action(Receive)
            {
                trigger OnAction()
                begin
                    RSetup.Get;
                    RSetup.TestField(RSetup."Resource Admin");
                    if UserSetup.Get(UserId) then SenderAddress := UserSetup."E-Mail";
                    if UserSetup.Get(RSetup."Resource Admin") then Recepient.Add(UserSetup."E-Mail");
                    Body := StrSubstNo('I acknowledge the reception of the Letter No % 1 ', Rec."No.");
                    SMTP.Create(Recepient, 'LETTERS', Body, true);
                    Email.Send(SMTP);
                    Rec.Received := true;
                    Rec.Receiver := UserId;
                    Rec.Modify;
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Alert := '';
        if Rec.Find('-') then begin
            repeat
                if Rec.Date <> 0D then begin
                    if Rec."Dispatch Date" = 0D then begin
                        NewDate := CalcDate('2W', Rec.Date);
                        if Today >= NewDate then Alert := 'This latter is due and needs to be actioned';
                        // MODIFY;
                    end;
                end;
            until Rec.Next = 0;
        end;
    end;

    var
        RSetup: Record "Resource Centre Setup";
        Recepient: list of [Text];
        Body: Text[250];
        SenderAddress: Text[250];
        UserSetup: Record "User Setup";
        Emp: Record Employee;
        SMTP: Codeunit "Email Message";
        Email: Codeunit email;
        NewDate: Date;
        Alert: Text[100];
}
