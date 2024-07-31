page 50673 "Deductions Imported"
{
    PageType = List;
    SourceTable = "Deduction 2";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Emp No."; Rec."Emp No.")
                {
                }
                field(D001; Rec.D001)
                {
                }
                field(D002; Rec.D002)
                {
                }
                field(D003; Rec.D003)
                {
                }
                field(D004; Rec.D004)
                {
                }
                field(D005; Rec.D005)
                {
                }
                field(D006; Rec.D006)
                {
                }
                field(D007; Rec.D007)
                {
                }
                field(D008; Rec.D008)
                {
                }
                field(D009; Rec.D009)
                {
                }
                field(D010; Rec.D010)
                {
                }
                field(D011; Rec.D011)
                {
                }
                field(D012; Rec.D012)
                {
                }
                field(D013; Rec.D013)
                {
                }
                field(D014; Rec.D014)
                {
                }
                field(D015; Rec.D015)
                {
                }
                field(D016; Rec.D016)
                {
                }
                field(D017; Rec.D017)
                {
                }
                field(D018; Rec.D018)
                {
                }
                field(D019; Rec.D019)
                {
                }
                field(D020; Rec.D020)
                {
                }
                field(D021; Rec.D021)
                {
                }
                field(D022; Rec.D022)
                {
                }
                field(D023; Rec.D023)
                {
                }
                field(D024; Rec.D024)
                {
                }
                field(D025; Rec.D025)
                {
                }
                field(D026; Rec.D026)
                {
                }
                field(D027; Rec.D027)
                {
                }
                field(D028; Rec.D028)
                {
                }
                field(D029; Rec.D029)
                {
                }
                field(D030; Rec.D030)
                {
                }
                field(D031; Rec.D031)
                {
                }
                field(D032; Rec.D032)
                {
                }
                field(D033; Rec.D033)
                {
                }
                field(D034; Rec.D034)
                {
                }
                field(D035; Rec.D035)
                {
                }
                field(D036; Rec.D036)
                {
                }
                field(D037; Rec.D037)
                {
                }
                field(D038; Rec.D038)
                {
                }
                field(D039; Rec.D039)
                {
                }
                field(D040; Rec.D040)
                {
                }
                field(D041; Rec.D041)
                {
                }
                field(D042; Rec.D042)
                {
                }
                field(DO43; Rec.DO43)
                {
                }
                field(D044; Rec.D044)
                {
                }
                field(D045; Rec.D045)
                {
                }
                field(D046; Rec.D046)
                {
                }
                field(D047; Rec.D047)
                {
                }
                field(D048; Rec.D048)
                {
                }
                field(D049; Rec.D049)
                {
                }
                field(D050; Rec.D050)
                {
                }
                field(D051; Rec.D051)
                {
                }
                field(D052; Rec.D052)
                {
                }
                field(D054; Rec.D054)
                {
                }
                field(D055; Rec.D055)
                {
                }
                field(D056; Rec.D056)
                {
                }
                field(D057; Rec.D057)
                {
                }
                field(D058; Rec.D058)
                {
                }
                field(D059; Rec.D059)
                {
                }
                field(D060; Rec.D060)
                {
                }
                field(D061; Rec.D061)
                {
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            action("Import Deductions")
            {
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /*
                    CLEAR(DedImport);
                    DedImport.RUN;
                    */
                    Clear(JanDedImport);
                    JanDedImport.Run;
                end;
            }
        }
    }
    var
        DedImport: XMLport "Ded Import";
        JanDedImport: XMLport "Jan Ded Import";
}
