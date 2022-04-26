require 'fox16'

include Fox

#RGB values for color constants
GREEN = FXRGB(0, 180, 0)
YELLOW = FXRGB(255, 255, 0)
BLACK = FXRGB(0, 0, 0)

class Rubdle < FXMainWindow
    def initialize(app)

        #I populate wordToGuess from File I/O and split it into letters for checking
        @wordToGuess = ""
        @hiddenLetter1 = ""
        @hiddenLetter2 = ""
        @hiddenLetter3 = ""
        @hiddenLetter4 = ""
        @hiddenLetter5 = ""

        @activeGame = 0
        @numGuesses = 0        
        @numLettersInWord = 0        
        super(app, "R U B D L E", :width => 250, :height => 420)        
        vertFrame = FXVerticalFrame.new(self, :opts => LAYOUT_CENTER_X|PACK_UNIFORM_WIDTH, :vSpacing => 10)
        horzFrame1 = FXHorizontalFrame.new(vertFrame)
        #initialize the Rubdle board with blank spaces
        @text1_1 = "  "
        @text1_2 = "  "
        @text1_3 = "  "
        @text1_4 = "  "
        @text1_5 = "  "

        @text2_1 = "  "
        @text2_2 = "  "
        @text2_3 = "  "
        @text2_4 = "  "
        @text2_5 = "  "

        @text3_1 = "  "
        @text3_2 = "  "
        @text3_3 = "  "
        @text3_4 = "  "
        @text3_5 = "  "

        @text4_1 = "  "
        @text4_2 = "  "
        @text4_3 = "  "
        @text4_4 = "  "
        @text4_5 = "  "

        @text5_1 = "  "
        @text5_2 = "  "
        @text5_3 = "  "
        @text5_4 = "  "
        @text5_5 = "  "

        @text6_1 = "  "
        @text6_2 = "  "
        @text6_3 = "  "
        @text6_4 = "  "
        @text6_5 = "  "        
        @frame1_1 = FXLabel.new(horzFrame1, @text1_1, :opts => FRAME_SUNKEN)        
        @frame1_2 = FXLabel.new(horzFrame1, @text1_2, :opts => FRAME_SUNKEN)
        @frame1_3 = FXLabel.new(horzFrame1, @text1_3, :opts => FRAME_SUNKEN)
        @frame1_4 = FXLabel.new(horzFrame1, @text1_4, :opts => FRAME_SUNKEN)
        @frame1_5 = FXLabel.new(horzFrame1, @text1_5, :opts => FRAME_SUNKEN)

        horzFrame2 = FXHorizontalFrame.new(vertFrame)
        @frame2_1 = FXLabel.new(horzFrame2, @text2_1, :opts => FRAME_SUNKEN)        
        @frame2_2 = FXLabel.new(horzFrame2, @text2_2, :opts => FRAME_SUNKEN)
        @frame2_3 = FXLabel.new(horzFrame2, @text2_3, :opts => FRAME_SUNKEN)
        @frame2_4 = FXLabel.new(horzFrame2, @text2_4, :opts => FRAME_SUNKEN)
        @frame2_5 = FXLabel.new(horzFrame2, @text2_5, :opts => FRAME_SUNKEN)
       
        horzFrame3 = FXHorizontalFrame.new(vertFrame)
        @frame3_1 = FXLabel.new(horzFrame3, @text3_1, :opts => FRAME_SUNKEN)        
        @frame3_2 = FXLabel.new(horzFrame3, @text3_2, :opts => FRAME_SUNKEN)
        @frame3_3 = FXLabel.new(horzFrame3, @text3_3, :opts => FRAME_SUNKEN)
        @frame3_4 = FXLabel.new(horzFrame3, @text3_4, :opts => FRAME_SUNKEN)
        @frame3_5 = FXLabel.new(horzFrame3, @text3_5, :opts => FRAME_SUNKEN)

        horzFrame4 = FXHorizontalFrame.new(vertFrame)
        @frame4_1 = FXLabel.new(horzFrame4, @text4_1, :opts => FRAME_SUNKEN)        
        @frame4_2 = FXLabel.new(horzFrame4, @text4_2, :opts => FRAME_SUNKEN)
        @frame4_3 = FXLabel.new(horzFrame4, @text4_3, :opts => FRAME_SUNKEN)
        @frame4_4 = FXLabel.new(horzFrame4, @text4_4, :opts => FRAME_SUNKEN)
        @frame4_5 = FXLabel.new(horzFrame4, @text4_5, :opts => FRAME_SUNKEN)

        horzFrame5 = FXHorizontalFrame.new(vertFrame)
        @frame5_1 = FXLabel.new(horzFrame5, @text5_1, :opts => FRAME_SUNKEN)        
        @frame5_2 = FXLabel.new(horzFrame5, @text5_2, :opts => FRAME_SUNKEN)
        @frame5_3 = FXLabel.new(horzFrame5, @text5_3, :opts => FRAME_SUNKEN)
        @frame5_4 = FXLabel.new(horzFrame5, @text5_4, :opts => FRAME_SUNKEN)
        @frame5_5 = FXLabel.new(horzFrame5, @text5_5, :opts => FRAME_SUNKEN)

        horzFrame6 = FXHorizontalFrame.new(vertFrame)
        @frame6_1 = FXLabel.new(horzFrame6, @text6_1, :opts => FRAME_SUNKEN)        
        @frame6_2 = FXLabel.new(horzFrame6, @text6_2, :opts => FRAME_SUNKEN)
        @frame6_3 = FXLabel.new(horzFrame6, @text6_3, :opts => FRAME_SUNKEN)
        @frame6_4 = FXLabel.new(horzFrame6, @text6_4, :opts => FRAME_SUNKEN)
        @frame6_5 = FXLabel.new(horzFrame6, @text6_5, :opts => FRAME_SUNKEN)

        vertFrameKeys = FXVerticalFrame.new(self, :opts => LAYOUT_CENTER_X|PACK_UNIFORM_WIDTH, :vSpacing => 5)

        #create the frames for the keyboard in a "keyboard-like" layout
        keyboardFrame1 = FXHorizontalFrame.new(vertFrameKeys)
        keyboardFrame1.padLeft = 10
        @q_button = FXButton.new(keyboardFrame1, "Q")
        @q_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("Q")
            end
        end
        @w_button = FXButton.new(keyboardFrame1, "W")
        @w_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("W")
            end
        end
        @e_button = FXButton.new(keyboardFrame1, "E")
        @e_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("E")
            end
        end
        @r_button = FXButton.new(keyboardFrame1, "R")
        @r_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("R")
            end
        end
        @t_button = FXButton.new(keyboardFrame1, "T")
        @t_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("T")
            end
        end
        @@y_button = FXButton.new(keyboardFrame1, "Y")
        @@y_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("Y")
            end
        end
        @u_button = FXButton.new(keyboardFrame1, "U")
        @u_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("U")
            end
        end
        @i_button = FXButton.new(keyboardFrame1, "I")
        @i_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("I")
            end
        end
        @o_button = FXButton.new(keyboardFrame1, "O")
        @o_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("O")
            end
        end
        @p_button = FXButton.new(keyboardFrame1, "P")
        @p_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("P")
            end
        end

        #second row of keys
        keyboardFrame2 = FXHorizontalFrame.new(vertFrameKeys)
        keyboardFrame2.padLeft = 28
        @a_button = FXButton.new(keyboardFrame2, "A")
        @a_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("A")
            end
        end
        @s_button = FXButton.new(keyboardFrame2, "S")
        @s_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("S")
            end
        end
        @d_button = FXButton.new(keyboardFrame2, "D")
        @d_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("D")
            end
        end
        @f_button = FXButton.new(keyboardFrame2, "F")
        @f_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("F")
            end
        end
        @g_button = FXButton.new(keyboardFrame2, "G")
        @g_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("G")
            end
        end
        @h_button = FXButton.new(keyboardFrame2, "H")
        @h_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("H")
            end
        end
        @j_button = FXButton.new(keyboardFrame2, "J")
        @j_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("J")
            end
        end
        @k_button = FXButton.new(keyboardFrame2, "K")
        @k_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("K")
            end
        end
        @l_button = FXButton.new(keyboardFrame2, "L")
        @l_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("L")
            end
        end

        #third row of keys
        keyboardFrame3 = FXHorizontalFrame.new(vertFrameKeys)        
        del_button = FXButton.new(keyboardFrame3, "Del")
        del_button.connect(SEL_COMMAND) do
            deleteEntry()
        end
        @z_button = FXButton.new(keyboardFrame3, "Z")
        @z_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("Z")
            end
        end
        @x_button = FXButton.new(keyboardFrame3, "X")
        @x_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("X")
            end
        end
        @c_button = FXButton.new(keyboardFrame3, "C")
        @c_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("C")
            end
        end
        @v_button = FXButton.new(keyboardFrame3, "V")
        @v_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("V")
            end
        end
        @b_button = FXButton.new(keyboardFrame3, "B")
        @b_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("B")
            end
        end
        @n_button = FXButton.new(keyboardFrame3, "N")
        @n_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("N")
            end
        end
        @m_button = FXButton.new(keyboardFrame3, "M")  
        @m_button.connect(SEL_COMMAND) do
            if (@activeGame == 1 and @numLettersInWord <= 4)
                sendLetter("M")
            end
        end
        enter_button = FXButton.new(keyboardFrame3, "Enter")
        enter_button.connect(SEL_COMMAND) do                        
            if (@activeGame == 1 && @numLettersInWord == 5)
                enterGuess()
                @numLettersInWord = 0
            end
        end

        gameButtonsFrame = FXHorizontalFrame.new(vertFrameKeys)
        newGameButton = FXButton.new(gameButtonsFrame, "New Game", :opts => LAYOUT_CENTER_X|FRAME_LINE)        
        newGameButton.connect(SEL_COMMAND) do
            newGame()
        end
        @endgameBanner = FXLabel.new(vertFrameKeys, "Press New Game to start!", :opts => LAYOUT_CENTER_X)
        
    end

    def sendLetter(letter)
        case @numGuesses
        when 0
            case @numLettersInWord
            when 0
                @text1_1 = letter
                @frame1_1.text = @text1_1
            when 1
                @text1_2 = letter
                @frame1_2.text = @text1_2
            when 2
                @text1_3 = letter
                @frame1_3.text = @text1_3
            when 3
                @text1_4 = letter
                @frame1_4.text = @text1_4
            when 4
                @text1_5 = letter
                @frame1_5.text = @text1_5
            end
        when 1
            case @numLettersInWord
            when 0
                @text2_1 = letter
                @frame2_1.text = @text2_1
            when 1
                @text2_2 = letter
                @frame2_2.text = @text2_2
            when 2
                @text2_3 = letter
                @frame2_3.text = @text2_3
            when 3
                @text2_4 = letter
                @frame2_4.text = @text2_4
            when 4
                @text2_5 = letter
                @frame2_5.text = @text2_5
            end
        when 2
            case @numLettersInWord
            when 0
                @text3_1 = letter
                @frame3_1.text = @text3_1
            when 1
                @text3_2 = letter
                @frame3_2.text = @text3_2
            when 2
                @text3_3 = letter
                @frame3_3.text = @text3_3
            when 3
                @text3_4 = letter
                @frame3_4.text = @text3_4
            when 4
                @text3_5 = letter
                @frame3_5.text = @text3_5
            end
        when 3
            case @numLettersInWord
            when 0
                @text4_1 = letter
                @frame4_1.text = @text4_1
            when 1
                @text4_2 = letter
                @frame4_2.text = @text4_2
            when 2
                @text4_3 = letter
                @frame4_3.text = @text4_3
            when 3
                @text4_4 = letter
                @frame4_4.text = @text4_4
            when 4
                @text4_5 = letter
                @frame4_5.text = @text4_5
            end
        when 4
            case @numLettersInWord
            when 0
                @text5_1 = letter
                @frame5_1.text = @text5_1
            when 1
                @text5_2 = letter
                @frame5_2.text = @text5_2
            when 2
                @text5_3 = letter
                @frame5_3.text = @text5_3
            when 3
                @text5_4 = letter
                @frame5_4.text = @text5_4
            when 4
                @text5_5 = letter
                @frame5_5.text = @text5_5
            end
        when 5
            case @numLettersInWord
            when 0
                @text6_1 = letter
                @frame6_1.text = @text6_1
            when 1
                @text6_2 = letter
                @frame6_2.text = @text6_2
            when 2
                @text6_3 = letter
                @frame6_3.text = @text6_3
            when 3
                @text6_4 = letter
                @frame6_4.text = @text6_4
            when 4
                @text6_5 = letter
                @frame6_5.text = @text6_5
            end
        end
        if (@numLettersInWord < 5)
            @numLettersInWord += 1            
        end
    end


    def enterGuess
        numCorrectLetters = 0
        case @numGuesses
        when 0
            if (@hiddenLetter1 == @text1_1)
                @frame1_1.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text1_1)
                @frame1_1.textColor = YELLOW
            end
            if (@hiddenLetter2 == @text1_2)
                @frame1_2.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text1_2)
                @frame1_2.textColor = YELLOW
            end
            if (@hiddenLetter3 == @text1_3)
                @frame1_3.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text1_3)
                @frame1_3.textColor = YELLOW
            end
            if (@hiddenLetter4 == @text1_4)
                @frame1_4.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text1_4)
                @frame1_4.textColor = YELLOW
            end
            if (@hiddenLetter5 == @text1_5)
                @frame1_5.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text1_5)
                @frame1_5.textColor = YELLOW
            end
        when 1
            if (@hiddenLetter1 == @text2_1)
                @frame2_1.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text2_1)
                @frame2_1.textColor = YELLOW
            end
            if (@hiddenLetter2 == @text2_2)
                @frame2_2.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text2_2)
                @frame2_2.textColor = YELLOW
            end
            if (@hiddenLetter3 == @text2_3)
                @frame2_3.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text2_3)
                @frame2_3.textColor = YELLOW
            end
            if (@hiddenLetter4 == @text2_4)
                @frame2_4.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text2_4)
                @frame2_4.textColor = YELLOW
            end
            if (@hiddenLetter5 == @text2_5)
                @frame2_5.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text2_5)
                @frame2_5.textColor = YELLOW
            end
        when 2
            if (@hiddenLetter1 == @text3_1)
                @frame3_1.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text3_1)
                @frame3_1.textColor = YELLOW
            end
            if (@hiddenLetter2 == @text3_2)
                @frame3_2.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text3_2)
                @frame3_2.textColor = YELLOW
            end
            if (@hiddenLetter3 == @text3_3)
                @frame3_3.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text3_3)
                @frame3_3.textColor = YELLOW
            end
            if (@hiddenLetter4 == @text3_4)
                @frame3_4.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text3_4)
                @frame3_4.textColor = YELLOW
            end
            if (@hiddenLetter5 == @text3_5)
                @frame3_5.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text3_5)
                @frame3_5.textColor = YELLOW
            end
        when 3
            if (@hiddenLetter1 == @text4_1)
                @frame4_1.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text4_1)
                @frame4_1.textColor = YELLOW
            end
            if (@hiddenLetter2 == @text4_2)
                @frame4_2.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text4_2)
                @frame4_2.textColor = YELLOW
            end
            if (@hiddenLetter3 == @text4_3)
                @frame4_3.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text4_3)
                @frame4_3.textColor = YELLOW
            end
            if (@hiddenLetter4 == @text4_4)
                @frame4_4.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text4_4)
                @frame4_4.textColor = YELLOW
            end
            if (@hiddenLetter5 == @text4_5)
                @frame4_5.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text4_5)
                @frame4_5.textColor = YELLOW
            end     
        when 4
            if (@hiddenLetter1 == @text5_1)
                @frame5_1.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text5_1)
                @frame5_1.textColor = YELLOW
            end
            if (@hiddenLetter2 == @text5_2)
                @frame5_2.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text5_2)
                @frame5_2.textColor = YELLOW
            end
            if (@hiddenLetter3 == @text5_3)
                @frame5_3.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text5_3)
                @frame5_3.textColor = YELLOW
            end
            if (@hiddenLetter4 == @text5_4)
                @frame5_4.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text5_4)
                @frame5_4.textColor = YELLOW
            end
            if (@hiddenLetter5 == @text5_5)
                @frame5_5.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text5_5)
                @frame5_5.textColor = YELLOW
            end
        when 5
            if (@hiddenLetter1 == @text6_1)
                @frame6_1.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text6_1)
                @frame6_1.textColor = YELLOW
            end
            if (@hiddenLetter2 == @text6_2)
                @frame6_2.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text6_2)
                @frame6_2.textColor = YELLOW
            end
            if (@hiddenLetter3 == @text6_3)
                @frame6_3.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text6_3)
                @frame6_3.textColor = YELLOW
            end
            if (@hiddenLetter4 == @text6_4)
                @frame6_4.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text6_4)
                @frame6_4.textColor = YELLOW
            end
            if (@hiddenLetter5 == @text6_5)
                @frame6_5.textColor = GREEN
                numCorrectLetters += 1
            elsif (@wordToGuess.include? @text6_5)
                @frame6_5.textColor = YELLOW
            end
        end

        if (numCorrectLetters == 5)
            congratulations()
        end
        @numGuesses += 1
        if (@numGuesses == 6 && numCorrectLetters != 5)
            youLose()
        end
    end

    #method to congratulate the player on guessing the correct word
    def congratulations
        @endgameBanner.text = "Congratulations you win!"
        @activeGame = 0
    end

    def youLose()
        @endgameBanner.text = "The word was " + @wordToGuess
        @activeGame = 0
    end


    #method to delete the latest letter input
    def deleteEntry
        case @numGuesses
        when 0
            case @numLettersInWord
            when 1
                @frame1_1.text = "  "
            when 2
                @frame1_2.text = "  "
            when 3
                @frame1_3.text = "  "
            when 4
                @frame1_4.text = "  "
            when 5
                @frame1_5.text = "  "
            end
        when 1
            case @numLettersInWord
            when 1
                @frame2_1.text = "  "
            when 2
                @frame2_2.text = "  "
            when 3
                @frame2_3.text = "  "
            when 4
                @frame2_4.text = "  "
            when 5
                @frame2_5.text = "  "
            end
        when 2
            case @numLettersInWord
            when 1
                @frame3_1.text = "  "
            when 2
                @frame3_2.text = "  "
            when 3
                @frame3_3.text = "  "
            when 4
                @frame3_4.text = "  "
            when 5
                @frame3_5.text = "  "
            end
        when 3
            case @numLettersInWord
            when 1
                @frame4_1.text = "  "
            when 2
                @frame4_2.text = "  "
            when 3
                @frame4_3.text = "  "
            when 4
                @frame4_4.text = "  "
            when 5
                @frame4_5.text = "  "
            end
        when 4
            case @numLettersInWord
            when 1
                @frame5_1.text = "  "
            when 2
                @frame5_2.text = "  "
            when 3
                @frame5_3.text = "  "
            when 4
                @frame5_4.text = "  "
            when 5
                @frame5_5.text = "  "
            end
        when 5
            case @numLettersInWord
            when 1
                @frame6_1.text = "  "
            when 2
                @frame6_2.text = "  "
            when 3
                @frame6_3.text = "  "
            when 4
                @frame6_4.text = "  "
            when 5
                @frame6_5.text = "  "
            end
        end
        if (@numLettersInWord > 0)
            @numLettersInWord -= 1
        end
    end

    
    #Method to start a new game of Rubdle
    def newGame        
        puts "New Game!"        
        @numGuesses = 0
        @numLettersInWord = 0
        @activeGame = 1
        @endgameBanner.text = ""
        clearBoard()
        chooseWord()
        splitWord()
        puts @wordToGuess
    end

    #Resets the frame objects to blank frames and reset text color to black
    def clearBoard()
        @frame1_1.text = "  "        
        @frame1_2.text = "  "
        @frame1_3.text = "  "
        @frame1_4.text = "  "
        @frame1_5.text = "  "

        @frame2_1.text = "  "
        @frame2_2.text = "  "
        @frame2_3.text = "  "
        @frame2_4.text = "  "
        @frame2_5.text = "  "

        @frame3_1.text = "  "
        @frame3_2.text = "  "
        @frame3_3.text = "  "
        @frame3_4.text = "  "
        @frame3_5.text = "  "

        @frame4_1.text = "  "
        @frame4_2.text = "  "
        @frame4_3.text = "  "
        @frame4_4.text = "  "
        @frame4_5.text = "  "

        @frame5_1.text = "  "
        @frame5_2.text = "  "
        @frame5_3.text = "  "
        @frame5_4.text = "  "
        @frame5_5.text = "  "

        @frame6_1.text = "  "
        @frame6_2.text = "  "
        @frame6_3.text = "  "
        @frame6_4.text = "  "
        @frame6_5.text = "  "

        @frame1_1.textColor = BLACK
        @frame1_2.textColor = BLACK
        @frame1_3.textColor = BLACK
        @frame1_4.textColor = BLACK
        @frame1_5.textColor = BLACK

        @frame2_1.textColor = BLACK
        @frame2_2.textColor = BLACK
        @frame2_3.textColor = BLACK
        @frame2_4.textColor = BLACK
        @frame2_5.textColor = BLACK

        @frame3_1.textColor = BLACK
        @frame3_2.textColor = BLACK
        @frame3_3.textColor = BLACK
        @frame3_4.textColor = BLACK
        @frame3_5.textColor = BLACK

        @frame4_1.textColor = BLACK
        @frame4_2.textColor = BLACK
        @frame4_3.textColor = BLACK
        @frame4_4.textColor = BLACK
        @frame4_5.textColor = BLACK

        @frame5_1.textColor = BLACK
        @frame5_2.textColor = BLACK
        @frame5_3.textColor = BLACK
        @frame5_4.textColor = BLACK
        @frame5_5.textColor = BLACK

        @frame6_1.textColor = BLACK
        @frame6_2.textColor = BLACK
        @frame6_3.textColor = BLACK
        @frame6_4.textColor = BLACK
        @frame6_5.textColor = BLACK
    end

    #opens file words.txt and chooses a random 5 letter word from the list
    #assigns to @wordToGuess
    def chooseWord
        wordsFile = File.read("words.txt")
        words = wordsFile.split("\n")        
        @wordToGuess =  words[rand(0..words.size-1)].upcase        
    end    

    #split the chosen word into individual letters for checking guesses
    def splitWord
        splitWord = @wordToGuess.split("")
        @hiddenLetter1 = splitWord[0]        
        @hiddenLetter2 = splitWord[1]
        @hiddenLetter3 = splitWord[2]
        @hiddenLetter4 = splitWord[3]
        @hiddenLetter5 = splitWord[4]
    end

    def create
        super
        show(PLACEMENT_SCREEN)        
    end    
end

if __FILE__ == $0
    FXApp.new do |app|
        Rubdle.new(app)
        app.create
        app.run        
    end
end